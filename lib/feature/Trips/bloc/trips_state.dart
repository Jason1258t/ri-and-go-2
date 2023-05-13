part of 'trips_bloc.dart';

@immutable
abstract class TripsState {}

class TripsInitial extends TripsState {}

class TripsLoadingState extends TripsState {}

class TripsLoadedState extends TripsState {}

class TripsFailState extends TripsState {}

class TripsInitialLoadState extends TripsState {
  final TripFilter filter;

  TripsInitialLoadState({required this.filter});
}