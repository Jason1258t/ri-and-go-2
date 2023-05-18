part of 'user_trips_bloc.dart';

@immutable
abstract class UserTripsEvent {}

class UserTripsInitialEvent extends UserTripsEvent {}

class UserTripsSubscribeEvent extends UserTripsEvent {}

class UserTripsLoadingEvent extends UserTripsEvent {}

class UserTripsSuccessEvent extends UserTripsEvent {}

class UserTripsFailEvent extends UserTripsEvent {}

class UserTripsDeleteEvent extends UserTripsEvent {
  final int tripId;

  UserTripsDeleteEvent({required this.tripId});
}

class UserTripsEditEvent extends UserTripsEvent {
  final TripModel trip;

  UserTripsEditEvent({required this.trip});
}

class UserTripsCommitChange extends UserTripsEvent {
  final TripEditModel tripChanges;

  UserTripsCommitChange({required this.tripChanges});
}

class UserTripsChangesFailEvent extends UserTripsEvent {}

class UserTripsChangesSuccessEvent extends UserTripsEvent {}
