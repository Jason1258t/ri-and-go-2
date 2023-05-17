part of 'creator_bloc.dart';

@immutable
abstract class CreatorEvent {}

class CreatorSubscribeEvent extends CreatorEvent {}

class CreatorWaitEvent extends CreatorEvent {}

class CreatorInitialLoadEvent extends CreatorEvent {
  final int userId;
  CreatorInitialLoadEvent({required this.userId});
}

class CreatorLoadingEvent extends CreatorEvent {}

class CreatorSuccessEvent extends CreatorEvent {}

class CreatorFailEvent extends CreatorEvent {}