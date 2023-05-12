import 'dart:math';

import 'package:riandgo2/services/api_services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/models.dart';

enum ProfileStateEnum { loading, success, fail }
enum ProfileEditingStateEnum {wait, loading, success, fail}

class ProfileRepository {
  final ApiService apiService;

  BehaviorSubject<ProfileStateEnum> profileState = BehaviorSubject<ProfileStateEnum>.seeded(ProfileStateEnum.loading);
  BehaviorSubject<ProfileEditingStateEnum> profileEditState = BehaviorSubject<ProfileEditingStateEnum>.seeded(ProfileEditingStateEnum.wait);

  ProfileRepository({required this.apiService});

  late User userInfo;
  late int userId;
  bool profileLoaded = false;

  bool isProfileLoaded() {
    return profileLoaded;
  }

  void convertServerData(Map data) {
    userInfo = User(
      name: data['name'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      contactUrl: data['contactUrl']
    );
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

  }
}