import 'dart:developer' as dev;
import 'dart:math';

import 'package:riandgo2/feature/profile/data/profile_repository.dart';
import 'package:riandgo2/models/models.dart';
import 'package:riandgo2/services/api_services.dart';
import 'package:rxdart/rxdart.dart';

enum TripsStateEnum { loading, success, fail }

enum CreatorStateEnum { waiting, loading, success, fail }

enum FollowingStateEnum { loading, success, fail }

class TripsRepository {
  final ApiService apiService;
  late User creatorInfo;
  late List _followedTrips;
  TripFilter _filter = TripFilter();

  List<TripModel> tripsFalse = [];
  List<TripModel> tripsTrue = [];

  TripsRepository({required this.apiService});

  final BehaviorSubject<TripsStateEnum> tripsState =
      BehaviorSubject<TripsStateEnum>.seeded(TripsStateEnum.loading);

  final BehaviorSubject<CreatorStateEnum> creatorState =
      BehaviorSubject<CreatorStateEnum>.seeded(CreatorStateEnum.waiting);

  final BehaviorSubject<FollowingStateEnum> followState =
      BehaviorSubject<FollowingStateEnum>.seeded(FollowingStateEnum.loading);

  late List<TripModel> tripList;

  void setTripList(List<TripModel> trips, bool tripsType) {
    if (tripsType) {
      tripsTrue = trips;
    } else {
      tripsFalse = trips;
    }
  }

  void setFollowedTrips(List tripsIds) {
    dev.log('SetFollowedTrips--------------------------------------$tripsIds');
    _followedTrips = tripsIds;
  }

  bool isEmptyTrips() {
    if (_filter.type!) {
      return tripsTrue.isEmpty;
    } else {
      return tripsFalse.isEmpty;
    }
  }

  List<TripModel> getTrips() {
    if (_filter.type!) {
      return tripsTrue;
    } else {
      return tripsFalse;
    }
  }

  TripFilter getFilter() {
    return _filter;
  }

  void followTrip(int id, int userId) {
    followState.add(FollowingStateEnum.loading);
    final ind = getTripIndex(id);
    if (ind != -1) {
      if (_filter.type!) {
        tripsTrue[ind].followed = true;
      } else {
        tripsFalse[ind].followed = true;
      }
      apiService.followTrip(tripId: id, userId: userId);
      followState.add(FollowingStateEnum.success);
      _followedTrips.add(id);
    } else {
      dev.log('-----------------------кто-то даун');
      followState.add(FollowingStateEnum.fail);
    }
  }


  void unFollowTrip({required int tripId, required int userId}) {
    followState.add(FollowingStateEnum.loading);
    final ind = getTripIndex(tripId);

    if (ind != -1) {
      if (_filter.type!) {
        tripsTrue[ind].followed = false;
      } else {
        tripsFalse[ind].followed = false;
      }

    }
  }

  int getTripIndex(int id) {
    for (var i in getTrips()) {
      if (i.itemId == id) {
        return getTrips().indexOf(i);
      }
    }
    return -1;
  }

  List<TripModel> markFollowedTrips(List<TripModel> trips) {
    for (var i in trips) {
      if (_followedTrips.contains(i.itemId)) {
        trips[trips.indexOf(i)].followed = true;
      }
    }
    return trips;
  }

  void loadTips(TripFilter? filter, bool necessarily) async {
    tripsState.add(TripsStateEnum.loading);
    bool needLoad = necessarily;

    if (isEmptyTrips()) {
      needLoad = true;
    }
    dev.log(necessarily.toString());
    dev.log('Загрузка---------------------------------$needLoad');
    if (needLoad) {
      try {
        List trips;
        if (filter == null) {
          trips = await apiService.defaultLoadTrips();
        } else {
          trips = await apiService.filteredLoadTrips(filter);
        }
        if (_filter.type!) {
          tripsTrue = markFollowedTrips(trips.parseTripList());
        } else {
          tripsFalse = markFollowedTrips(trips.parseTripList());
        }
      } catch (e) {
        tripsState.add(TripsStateEnum.fail);
        rethrow;
      }
    }
    tripsState.add(TripsStateEnum.success);
  }

  List<String> getRandomImage() {
    int n = Random().nextInt(2);
    if (n == 1) {
      return [
        'https://sportishka.com/uploads/posts/2022-03/1647538575_4-sportishka-com-p-poezdka-s-semei-na-mashine-turizm-krasivo-4.jpg',
        'https://aybaz.ru/wp-content/uploads/4/c/c/4ccfe1a1d3366c78552959f0c74d2622.jpeg'
      ];
    } else {
      return [
        'https://aybaz.ru/wp-content/uploads/4/c/c/4ccfe1a1d3366c78552959f0c74d2622.jpeg'
      ];
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
    final oldDate = _filter.date;
    final oldDeparture = _filter.departure;
    final oldArrival = _filter.arrive;
    _filter = TripFilter(
        date: newFilter.date ?? oldDate,
        departure: newFilter.departure ?? oldDeparture,
        arrive: newFilter.arrive ?? oldArrival,
        type: newFilter.type);
  }

  void clearFilter() {
    _filter = TripFilter(type: _filter.type);
  }
}
