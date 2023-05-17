part of 'creator_bloc.dart';

@immutable
abstract class CreatorState {}

class CreatorInitial extends CreatorState {}

class CreatorWaitingState extends CreatorState {}

class CreatorLoadingState extends CreatorState {}

class CreatorSuccessState extends CreatorState {
  final String name;
  final String email;
  final String phone;
  final String? contactUrl;

  CreatorSuccessState({required this.name, required this.email, required this.phone, required this.contactUrl});

}

class CreatorFailState extends CreatorState {}
