part of 'follow_bloc.dart';

@immutable
abstract class FollowEvent {}

class FollowSubscriptionEvent extends FollowEvent {}

class FollowInitialEvent extends FollowEvent {
  final int tripId;
  final int userId;

  FollowInitialEvent({required this.tripId, required this.userId});
}

class UnFollowInitialEvent extends FollowEvent {
  final int tripId;
  final int userId;

  UnFollowInitialEvent({required this.userId, required this.tripId});
}

class FollowProcessingEvent extends FollowEvent {}

class FollowSuccessEvent extends FollowEvent {}

class FollowFailEvent extends FollowEvent {}

class FollowAlreadyAvailableEvent extends FollowEvent {}