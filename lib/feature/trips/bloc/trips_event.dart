part of 'trips_bloc.dart';

@immutable
abstract class TripsEvent {}

class TripsInitialLoadEvent extends TripsEvent {
  final TripFilter? filter;
  final bool necessarily;

  TripsInitialLoadEvent({required this.filter, this.necessarily = false});
}

class TripsSubscriptionEvent extends TripsEvent {}

class TripsLoadingEvent extends TripsEvent {}

class TripsSuccessEvent extends TripsEvent {}

class TripsFailEvent extends TripsEvent {}

class TripsSetFilterEvent extends TripsEvent {
  final TripFilter filter;

  TripsSetFilterEvent({required this.filter});
}
