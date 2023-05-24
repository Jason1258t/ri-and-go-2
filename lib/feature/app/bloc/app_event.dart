part of 'app_bloc.dart';

abstract class AppEvent {}

class SubscripeAppEvent extends AppEvent {}

class LogoutAppEvent extends AppEvent {}

class AuthAppEvent extends AppEvent {}
class RegisterAppEvent extends AppEvent {}

class UnAuthAppEvent extends AppEvent {}

class LoadingAppEvent extends AppEvent {}
