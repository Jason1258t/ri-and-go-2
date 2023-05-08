part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class InitialAuthEvent extends AuthEvent {}

class LoadingAuthEvent extends AuthEvent {}

class SuccessAuthEvent extends AuthEvent {}

class FailAuthEvent extends AuthEvent {}

class SubscripeAuthEvent extends AuthEvent {}

class StartAuthEvent extends AuthEvent {
  final String login;
  final String password;

  StartAuthEvent({required this.login, required this.password});
}
