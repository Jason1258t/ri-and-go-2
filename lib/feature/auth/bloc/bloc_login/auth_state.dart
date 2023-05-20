part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailState extends AuthState {}

class AuthIncorrectlyEmailState extends AuthState {}

class AuthCorrectlyEmailState extends AuthState {}

class AuthIncorrectlyFieldState extends AuthState {}

class AuthCorrectlyFieldState extends AuthState {}
