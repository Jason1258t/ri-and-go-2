part of 'app_bloc.dart';

abstract class AppState {}

class InitialAppState extends AppState {}

class AuthAppState extends AppState {}

class RegisteredAppState extends AppState {}

class UnAuthAppState extends AppState {}

class LoadingAppState extends AppState {}
