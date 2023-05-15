part of 'navigator_bloc.dart';

@immutable
abstract class NavigatorScreenState {}

class NavigatorInitial extends NavigatorScreenState {}

class NavigateProfileState extends NavigatorScreenState {}
class NavigateSearchState extends NavigatorScreenState {}
class NavigatorWaitingState extends NavigatorScreenState {}