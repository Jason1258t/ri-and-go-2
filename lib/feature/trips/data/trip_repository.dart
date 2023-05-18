import 'dart:developer';
import 'dart:math';

import 'package:riandgo2/models/models.dart';
import 'package:riandgo2/services/api_services.dart';
import 'package:rxdart/rxdart.dart';

enum TripsStateEnum { loading, success, fail }

enum CreatorStateEnum { waiting, loading, success, fail }

class TripsRepository {
  final ApiService apiService;
  late User creatorInfo;
  TripFilter filter = TripFilter();

  TripsRepository({required this.apiService});

  final BehaviorSubject<TripsStateEnum> tripsState =
      BehaviorSubject<TripsStateEnum>.seeded(TripsStateEnum.loading);

  final BehaviorSubject<CreatorStateEnum> creatorState =
      BehaviorSubject<CreatorStateEnum>.seeded(CreatorStateEnum.waiting);

  late List<TripModel> tripList;

  void loadTips(TripFilter? filter) async {
    tripsState.add(TripsStateEnum.loading);
    try {
      List trips;
      if (filter == null) {
        trips = await apiService.defaultLoadTrips();
      } else {
        trips = await apiService.filteredLoadTrips(filter);
        // trips = await apiService.loadTripsCreators(trips);
      }
      tripList = trips.parseTripList();
      tripsState.add(TripsStateEnum.success);
    } catch (e) {
      tripsState.add(TripsStateEnum.fail);
      rethrow;
    }
  }

  List<String> getRandomImage() {
    int n = Random().nextInt(2);
    if (n == 1) {
      return ['https://sportishka.com/uploads/posts/2022-03/1647538575_4-sportishka-com-p-poezdka-s-semei-na-mashine-turizm-krasivo-4.jpg', 'https://aybaz.ru/wp-content/uploads/4/c/c/4ccfe1a1d3366c78552959f0c74d2622.jpeg'];
    } else {
      return ['https://aybaz.ru/wp-content/uploads/4/c/c/4ccfe1a1d3366c78552959f0c74d2622.jpeg'];
    }
  }

  void loadCreator(int id) async {
    creatorState.add(CreatorStateEnum.loading);
    try {
      Map<String, dynamic> data = await apiService.loadProfile(id: id);
      creatorInfo = data.parseUser();
      creatorState.add(CreatorStateEnum.success);
    } catch (e) {
      creatorState.add(CreatorStateEnum.fail);
      rethrow;
    }
  }

  void copyWithFilter(TripFilter newFilter) {
    final oldDate = filter.date;
    final oldDeparture = filter.departure;
    final oldArrival = filter.arrive;
    filter = TripFilter(
        date: newFilter.date ?? oldDate,
        departure: newFilter.departure ?? oldDeparture,
        arrive: newFilter.arrive ?? oldArrival,
        type: newFilter.type);
  }

  void clearFilter() {
    filter = TripFilter(type: filter.type);
  }
}
