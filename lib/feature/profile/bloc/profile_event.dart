part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}


class ProfileInitialLoadEvent extends ProfileEvent {}

class ProfileSubscribeEvent extends ProfileEvent {}

class ProfileLoadingEvent extends ProfileEvent {}

class ProfileLoadedEvent extends ProfileEvent {}

class ProfileErrorEvent extends ProfileEvent {}