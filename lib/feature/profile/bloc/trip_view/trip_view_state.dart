part of 'trip_view_bloc.dart';

@immutable
abstract class TripViewState {}

class TripViewInitial extends TripViewState {}

class TripViewLoadingState extends TripViewState {}

class TripViewSuccessLoadState extends TripViewState {}

class TripViewFailLoadState extends TripViewState {}