import 'dart:math';

import 'package:riandgo2/services/api_services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/models.dart';

enum ProfileStateEnum { loading, success, fail }
enum ProfileEditingStateEnum {wait, loading, success, fail}
enum UserTripsStateEnum {loading, success, fail}
enum AddTripStateEnum {wait, loading, success, fail}

class ProfileRepository {
  final ApiService apiService;

  BehaviorSubject<ProfileStateEnum> profileState = BehaviorSubject<ProfileStateEnum>.seeded(ProfileStateEnum.loading);
  BehaviorSubject<UserTripsStateEnum> tripsState = BehaviorSubject<UserTripsStateEnum>.seeded(UserTripsStateEnum.loading);
  BehaviorSubject<ProfileEditingStateEnum> profileEditState = BehaviorSubject<ProfileEditingStateEnum>.seeded(ProfileEditingStateEnum.wait);
  BehaviorSubject<AddTripStateEnum> addTripState = BehaviorSubject<AddTripStateEnum>.seeded(AddTripStateEnum.wait);

  ProfileRepository({required this.apiService});

  late User userInfo;
  late List<TripModel> userTrips;
  late int userId;
  bool profileLoaded = false;

  bool isProfileLoaded() {
    return profileLoaded;
  }

  Future<void> loadProfile() async {
    profileState.add(ProfileStateEnum.loading);
    try{
      Map<String, dynamic> data = await apiService.loadProfile(id: userId);
      userInfo = data.parseUser();
      print(data);
      profileLoaded = true;
      profileState.add(ProfileStateEnum.success);
    } catch (e) {
      profileLoaded = false;
      profileState.add(ProfileStateEnum.fail);
    }
  }

  Future<void> editProfile(Map newUserInfo) async {
    profileEditState.add(ProfileEditingStateEnum.loading);
    try {
      await apiService.editProfile(newInfo: newUserInfo);
      profileEditState.add(ProfileEditingStateEnum.success);
      loadProfile();
    } catch (e) {
      profileEditState.add(ProfileEditingStateEnum.fail);
    }
  }


  Future<void> loadTrips() async {
    tripsState.add(UserTripsStateEnum.loading);
    try {
      List data = await apiService.loadUserTrips(id: userId);
      userTrips = data.parseTripList();
      tripsState.add(UserTripsStateEnum.success);
    } catch (e) {
      tripsState.add(UserTripsStateEnum.fail);
      rethrow;
    }
  }

  Future<void> addTrip(AddTripModel trip) async {
    addTripState.add(AddTripStateEnum.loading);
    try {
      await apiService.addTrip(trip.toJson(userId));
    } catch (e) {
      addTripState.add(AddTripStateEnum.fail);
      rethrow;
    }
  }
}