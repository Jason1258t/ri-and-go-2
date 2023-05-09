part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class InitialRegisterEvent extends RegisterEvent {}

class SubscripeRegisterEvent extends RegisterEvent {}

class CollectingRegistrationInfoEvent extends RegisterEvent {
  final String? email;
  final String? phone;
  final String? name;
  final String? password;

  CollectingRegistrationInfoEvent(
      {this.email, this.phone, this.name, this.password});
}


class StartRegisterEvent extends RegisterEvent {
  final String email;
  final String phone;
  final String name;
  final String password;

  StartRegisterEvent({required this.password, required this.name, required this.email, required this.phone});
}


class SuccessRegisterEvent extends RegisterEvent {}
class RegisterLoadingEvent extends RegisterEvent {}
class RegisterFailEvent extends RegisterEvent {}
