import 'dart:developer' as dev;
import 'dart:math';

import 'package:riandgo2/feature/profile/data/profile_repository.dart';
import 'package:riandgo2/models/models.dart';
import 'package:riandgo2/repository/app_repository.dart';
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

  late int _userId;

  List<TripModel> tripsTrue = [];

  TripsRepository({required this.apiService});

  final BehaviorSubject<TripsStateEnum> tripsState =
      BehaviorSubject<TripsStateEnum>.seeded(TripsStateEnum.loading);

  final BehaviorSubject<CreatorStateEnum> creatorState =
      BehaviorSubject<CreatorStateEnum>.seeded(CreatorStateEnum.waiting);

  final BehaviorSubject<FollowingStateEnum> followState =
      BehaviorSubject<FollowingStateEnum>.seeded(FollowingStateEnum.loading);

  late List<TripModel> tripList;

  void initUserId(int userId) {
    _userId = userId;
  }

  void removeFollowedTrip(int itemId) {
    try {
      for (var i = 0; i < tripsTrue.length; i++) {
        if (tripsTrue[i].itemId == itemId) {
          _followedTrips.remove(itemId);
          tripsTrue[i].followed = false;
          tripsTrue[i].passengersCount -= 1;
        }
      }
      for (var i = 0; i < tripsFalse.length; i++) {
        if (tripsFalse[i].itemId == itemId) {
          _followedTrips.remove(itemId);
          tripsTrue[i].followed = false;
          tripsTrue[i].passengersCount -= 1;
        }

      }
    } catch (e) {
      rethrow;
    }

  }

  void setTripList(List<TripModel> trips, bool tripsType) {
    if (tripsType) {
      tripsTrue = trips;
    } else {
      tripsFalse = trips;
    }
  }

  void setFollowedTrips(List tripsIds) {
    _followedTrips = tripsIds;
  }

  bool isEmptyTrips() {
    if (_filter.type!) {
      return tripsTrue.isEmpty;
    } else {
      return tripsFalse.isEmpty;
    }
  }

  TripModel? getTripByItemId(int itemId) {
    for (var i in tripsTrue) {
      if (i.itemId == itemId) {
        return i;
      }
    }
    for (var i in tripsFalse) {
      if (i.itemId == itemId) {
        return i;
      }
    }
    return null;
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
    apiService.followTrip(tripId: id, userId: userId);
    if (ind != -1) {
      if (_filter.type!) {
        tripsTrue[ind].passengersCount++;
        tripsTrue[ind].followed = true;
      } else {
        tripsFalse[ind].passengersCount++;
        tripsFalse[ind].followed = true;
      }

      followState.add(FollowingStateEnum.success);
      _followedTrips.add(id);
    } else {
      followState.add(FollowingStateEnum.fail);
    }
  }

  void unFollowTrip({required int tripId, required int userId}) {
    followState.add(FollowingStateEnum.loading);
    final ind = getTripIndex(tripId);
    apiService.unFollowTrip(tripId: tripId, userId: userId);
    if (ind != -1) {
      if (_filter.type!) {
        tripsTrue[ind].passengersCount -= 1;
        tripsTrue[ind].followed = false;
      } else {
        tripsFalse[ind].passengersCount -= 1;
        tripsFalse[ind].followed = false;
      }

      followState.add(FollowingStateEnum.success);
      _followedTrips.remove(tripId);
    } else {
      followState.add(FollowingStateEnum.fail);
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

  List<TripModel> markFollowedAndCreatedTrips(List<TripModel> trips) {
    for (var i in trips) {
      if (_followedTrips.contains(i.itemId)) {
        trips[trips.indexOf(i)].followed = true;
      }
      if (trips[trips.indexOf(i)].authorId == _userId) {
        trips[trips.indexOf(i)].creator = true;
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
    if (needLoad) {
      try {
        List trips;
        if (filter == null) {
          trips = await apiService.defaultLoadTrips();
        } else {
          trips = await apiService.filteredLoadTrips(filter);
        }
        if (_filter.type!) {
          tripsTrue = markFollowedAndCreatedTrips(trips.parseTripList());
        } else {
          tripsFalse = markFollowedAndCreatedTrips(trips.parseTripList());
        }
      } catch (e) {
        tripsState.add(TripsStateEnum.fail);
        rethrow;
      }
    }
    tripsState.add(TripsStateEnum.success);
  }

  List<String> getRandomImage() {
    List imageUrls = [
      'https://sportishka.com/uploads/posts/2022-03/1647538575_4-sportishka-com-p-poezdka-s-semei-na-mashine-turizm-krasivo-4.jpg',
      //'https://aybaz.ru/wp-content/uploads/4/c/c/4ccfe1a1d3366c78552959f0c74d2622.jpeg',
      'https://krym-portal.ru/wp-content/uploads/2020/03/2112.jpg',
      'https://bestvietnam.ru/wp-content/uploads/2020/04/%D0%BF%D0%BE%D0%B5%D0%B7%D0%B4%D0%BA%D0%B0-%D0%B2-%D1%81%D1%82%D1%80%D0%B0%D0%BD%D1%83.jpg',
      'https://sportishka.com/uploads/posts/2022-03/1647538582_18-sportishka-com-p-poezdka-s-semei-na-mashine-turizm-krasivo-19.jpg',
      'https://avatars.dzeninfra.ru/get-zen_doc/1641332/pub_5e5d0734bb781f231c3120eb_5e5d38cdac9a236dd3d930b4/scale_1200',
      'https://avatars.dzeninfra.ru/get-zen_doc/3642096/pub_5f40d7464d12c246725dcd92_5f414bb82932bd7edaf1a762/scale_1200',
      'http://mobimg.b-cdn.net/v3/fetch/76/7602069934d8b190aa06e329f63364a1.jpeg',
      'https://ip1.anime-pictures.net/direct-images/894/89420a58045d7aa998aac25cc4716715.jpg?if=ANIME-PICTURES.NET_-_223219-1680x1050-original-volkswagen-range+murata-single-long+hair-black+hair.jpg',
      'https://oir.mobi/uploads/posts/2021-03/1616366674_14-p-anime-puteshestvie-23.jpg',
      'https://sun9-26.userapi.com/HormPGY__e8HtQTgpEuAerqfx9mzSAybhamQKg/ZL2Yn3corsk.jpg',
      'https://kartinkin.net/uploads/posts/2021-07/1625494967_50-kartinkin-com-p-anime-geroi-shchita-anime-krasivo-52.jpg',
    ];
    int n = Random().nextInt(2);
    if (n == 1) {
      return [
        imageUrls[Random().nextInt(imageUrls.length - 1)],
        imageUrls[Random().nextInt(imageUrls.length - 1)],
      ];
    } else {
      return [
        imageUrls[Random().nextInt(imageUrls.length - 1)],
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
