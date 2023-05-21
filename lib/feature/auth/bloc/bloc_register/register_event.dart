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


class StartRegisterEvent extends RegisterEvent {}


class SuccessRegisterEvent extends RegisterEvent {}
class RegisterLoadingEvent extends RegisterEvent {}
class RegisterFailEvent extends RegisterEvent {}


class FirstScreenCorrectCheckFieldsEvent extends RegisterEvent {
  final String email;
  final String phone;
  FirstScreenCorrectCheckFieldsEvent({required this.email, required this.phone});
}
class SecondScreenCorrectCheckFieldsEvent extends RegisterEvent {
  final String name;
  final String firstPassword;
  final String secondPassword;
  SecondScreenCorrectCheckFieldsEvent({required this.name, required this.firstPassword, required this.secondPassword});
}