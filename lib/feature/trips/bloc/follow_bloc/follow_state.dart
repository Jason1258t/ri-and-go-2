part of 'follow_bloc.dart';

@immutable
abstract class FollowState {}

class FollowInitial extends FollowState {}

class FollowProcessingState extends FollowState {}

class FollowSuccessState extends FollowState {}

class FollowFailState extends FollowState {}

class FollowAlreadyAvailableState extends FollowState {}