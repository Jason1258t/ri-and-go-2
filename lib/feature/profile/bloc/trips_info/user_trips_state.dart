part of 'user_trips_bloc.dart';

@immutable
abstract class UserTripsState {}

class UserTripsInitial extends UserTripsState {}

class UserTripsLoadingState extends UserTripsState {}

class UserTripsSuccessState extends UserTripsState {}

class UserTripsFailState extends UserTripsState {}


class UserTripsSuccessChangeState extends UserTripsState {}

class UserTripsFailChangeState extends UserTripsState {}