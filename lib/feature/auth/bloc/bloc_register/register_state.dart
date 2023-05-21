part of 'register_bloc.dart';



class RegisterState {}

class RegisterInitialState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterFailState extends RegisterState {}
class RegisterLoadingState extends RegisterState {}

class InvalidFirstScreenState extends RegisterState {
  final bool email;
  final bool phone;

  InvalidFirstScreenState({required this.phone, required this.email});
}
class InvalidSecondScreenState extends RegisterState {
  final bool name;
  final bool password;

  InvalidSecondScreenState({required this.name, required this.password});
}

class CorrectFirstScreen extends RegisterState {}
class CorrectSecondScreen extends RegisterState {}