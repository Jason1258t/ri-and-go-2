part of 'add_trip_bloc.dart';

@immutable
abstract class AddTripState {}

class AddTripInitial extends AddTripState {}

class AddTripLoadingState extends AddTripState {}

class AddTripSuccessState extends AddTripState {}

class AddTripFailState extends AddTripState {}

class AddTripWaitingState extends AddTripState {}

