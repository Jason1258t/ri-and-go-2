part of 'trip_view_bloc.dart';

@immutable
abstract class TripViewEvent {}

class TripViewInitialLoadEvent extends TripViewEvent {
  final int tripId;

  TripViewInitialLoadEvent({required this.tripId});
}

class TripViewLoadingEvent extends TripViewEvent {}

class TripViewSuccessEvent extends TripViewEvent {}

class TripViewFailEvent extends TripViewEvent {}
