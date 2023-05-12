import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:riandgo2/feature/profile/data/profile_repository.dart';

part 'user_trips_event.dart';

part 'user_trips_state.dart';

class UserTripsBloc extends Bloc<UserTripsEvent, UserTripsState> {
  final ProfileRepository _profileRepository;
  late final StreamSubscription _tripsStateSubscription;
  late final StreamSubscription _profileStateSubscription;

  UserTripsBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(UserTripsInitial()) {
    on<UserTripsSubscribeEvent>(_onSubscribe);
    on<UserTripsInitialEvent>(_onInitialLoading);
    on<UserTripsLoadingEvent>(_onLoading);
    on<UserTripsSuccessEvent>(_onSuccess);
    on<UserTripsFailEvent>(_onFail);
  }
  _onSubscribe (UserTripsSubscribeEvent event, emit) {
    _tripsStateSubscription = _profileRepository.tripsState.stream.listen((UserTripsStateEnum event) {
      if (event == UserTripsStateEnum.loading) add(UserTripsLoadingEvent());
      if (event == UserTripsStateEnum.success) add(UserTripsSuccessEvent());
      if (event == UserTripsStateEnum.fail) add(UserTripsFailEvent());
    });

    _profileStateSubscription = _profileRepository.profileState.stream.listen((ProfileStateEnum event) {
      if (event == ProfileStateEnum.success) add(UserTripsInitialEvent());
    });
  }

  _onInitialLoading(UserTripsInitialEvent event, emit) {
    _profileRepository.loadTrips();
  }

  _onLoading(UserTripsLoadingEvent event, emit) {
    emit(UserTripsLoadingState());
  }

  _onSuccess(UserTripsSuccessEvent event, emit) {
    emit(UserTripsSuccessState());
  }

  _onFail(UserTripsFailEvent event, emit) {
    emit(UserTripsFailState());
  }

}
