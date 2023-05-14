part of 'add_trip_bloc.dart';

@immutable
abstract class AddTripEvent {}

class AddTripSubscribeEvent extends AddTripEvent {}

class AddTripInitialEvent extends AddTripEvent {
  final AddTripModel trip;

  AddTripInitialEvent({required this.trip});
}

class AddTripLoadingEvent extends AddTripEvent {}

class AddTripWaitingEvent extends AddTripEvent {}

class AddTripSuccessEvent extends AddTripEvent {}

class AddTripFailEvent extends AddTripEvent {}