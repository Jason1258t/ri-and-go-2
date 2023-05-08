part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class InitialRegisterEvent extends RegisterEvent {}

class CollectingRegistrationInfoEvent extends RegisterEvent {
  final String email;
  final String phone;

  CollectingRegistrationInfoEvent({required this.email, required this.phone});
}


class StartRegisterEvent extends RegisterEvent {
  final String password;
  final String name;

  StartRegisterEvent({required this.password, required this.name});
}


class SuccessRegisterEvent extends RegisterEvent {}
class RegisterLoadingEvent extends RegisterEvent {}
class RegisterFailEvent extends RegisterEvent {}
