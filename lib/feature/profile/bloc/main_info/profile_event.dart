part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileInitialLoadEvent extends ProfileEvent {}

class ProfileSubscribeEvent extends ProfileEvent {}

class ProfileLoadingEvent extends ProfileEvent {}

class ProfileLoadedEvent extends ProfileEvent {}

class ProfileErrorEvent extends ProfileEvent {}

class ProfileEditInitialEvent extends ProfileEvent {
  final String name;
  final String email;
  final String phoneNumber;
  final String contactUrl;

  ProfileEditInitialEvent(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.contactUrl});
}

class ProfileEditLoadingEvent extends ProfileEvent {}

class ProfileEditSuccessEvent extends ProfileEvent {}

class ProfileEditFailEvent extends ProfileEvent {}
