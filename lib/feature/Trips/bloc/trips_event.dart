part of 'trips_bloc.dart';

@immutable
abstract class TripsEvent {}

class TripsInitialLoadEvent extends TripsEvent {
  final TripFilter? filter;

  TripsInitialLoadEvent({required this.filter});
}

class TripsSubscriptionEvent extends TripsEvent {}

class TripLoadingEvent extends TripsEvent {}

class TripsSuccessEvent extends TripsEvent {}

class TripsFailEvent extends TripsEvent {}