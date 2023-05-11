part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final String name;
  final String phone;
  final String email;

  ProfileLoadedState(
      {required this.name, required this.phone, required this.email});
}

class ProfileErrorState extends ProfileState {}

class ProfileEditLoadingState extends ProfileState {}

class ProfileEditSuccessState extends ProfileState {
  final String name;
  final String email;
  final String phoneNumber;
  final String contactUrl;

  ProfileEditSuccessState(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.contactUrl});
}

class ProfileEditFailState extends ProfileState {}
