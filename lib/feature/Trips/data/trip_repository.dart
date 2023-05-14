import 'package:riandgo2/models/models.dart';
import 'package:riandgo2/services/api_services.dart';
import 'package:rxdart/rxdart.dart';

enum TripsStateEnum { loading, success, fail }

class TripsRepository {
  final ApiService apiService;

  TripsRepository({required this.apiService});

  final BehaviorSubject<TripsStateEnum> tripsState =
      BehaviorSubject<TripsStateEnum>.seeded(TripsStateEnum.loading);

  late List<TripModel> tripList;

  void loadTips(TripFilter? filter) async {
    tripsState.add(TripsStateEnum.loading);
    try {
      List trips;
      if (filter == null) {
        trips = await apiService.defaultLoadTrips();
      } else {
        trips = await apiService.filteredLoadTrips(filter);
      }
      tripList = trips.parseTripList();
      tripsState.add(TripsStateEnum.success);
    } catch (e) {
      tripsState.add(TripsStateEnum.fail);
      rethrow;

    }
  }
}
