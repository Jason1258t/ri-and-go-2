import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:riandgo2/feature/profile/data/profile_repository.dart';
import 'package:riandgo2/models/TripEditModel.dart';
import 'package:riandgo2/models/models.dart';

part 'user_trips_event.dart';

part 'user_trips_state.dart';

class UserTripsBloc extends Bloc<UserTripsEvent, UserTripsState> {
  final ProfileRepository _profileRepository;
  late final StreamSubscription _tripsStateSubscription;
  late final StreamSubscription _profileStateSubscription;
  late final StreamSubscription _tripEditingState;

  UserTripsBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(UserTripsInitial()) {
    on<UserTripsSubscribeEvent>(_onSubscribe);
    on<UserTripsInitialEvent>(_onInitialLoading);
    on<UserTripsLoadingEvent>(_onLoading);
    on<UserTripsSuccessEvent>(_onSuccess);
    on<UserTripsFailEvent>(_onFail);
    on<UserTripsDeleteEvent>(_onDelete);
    on<UserTripsCommitChange>(_onEditTrip);
    on<UserTripsChangesSuccessEvent>(_onSuccessEdit);
    on<UserTripsChangesFailEvent>(_onFailEdit);
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

    _tripEditingState = _profileRepository.tripEditingState.stream.listen((event) {
      if (event == EditingTripStateEnum.fail) add(UserTripsChangesFailEvent());
      if (event == EditingTripStateEnum.success) add(UserTripsChangesSuccessEvent());
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

  _onDelete(UserTripsDeleteEvent event, emit) {
    _profileRepository.deleteTrip(event.tripId);
  }

  _onEditTrip(UserTripsCommitChange event, emit) {
    _profileRepository.editTrip(event.tripChanges);
  }

  _onSuccessEdit(UserTripsChangesSuccessEvent event, emit) {
    emit(UserTripsSuccessChangeState());
  }

  _onFailEdit(UserTripsChangesFailEvent event, emit) {
    emit(UserTripsFailChangeState());
  }

}
