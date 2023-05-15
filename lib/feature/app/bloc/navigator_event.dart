part of 'navigator_bloc.dart';

@immutable
abstract class NavigatorEvent {}

class NavigateProfileEvent extends NavigatorEvent {}
class NavigateSearchEvent extends NavigatorEvent {}
class NavigateWaitingEvent extends NavigatorEvent {}