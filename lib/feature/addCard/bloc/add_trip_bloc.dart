import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:riandgo2/feature/profile/data/profile_repository.dart';

import '../../../models/models.dart';

part 'add_trip_event.dart';

part 'add_trip_state.dart';

class AddTripBloc extends Bloc<AddTripEvent, AddTripState> {
  final ProfileRepository _profileRepository;
  late StreamSubscription addTripState;

  AddTripBloc(ProfileRepository profileRepository)
      : _profileRepository = profileRepository,
        super(AddTripInitial()) {
    on<AddTripSubscribeEvent>(_subscribe);
    on<AddTripInitialEvent>(_onInitialAdd);
    on<AddTripLoadingEvent>(_onLoading);
    on<AddTripSuccessEvent>(_onSuccess);
    on<AddTripFailEvent>(_onFail);
    on<AddTripWaitingEvent>(_onWait);
  }

  _subscribe(AddTripSubscribeEvent event, emit) {
    addTripState = _profileRepository.addTripState.stream.listen((event) {
      if (event == AddTripStateEnum.loading) add(AddTripLoadingEvent());
      if (event == AddTripStateEnum.success) add(AddTripSuccessEvent());
      if (event == AddTripStateEnum.fail) add(AddTripFailEvent());
      if (event == AddTripStateEnum.wait) add(AddTripWaitingEvent());
    });
  }

  _onInitialAdd(AddTripInitialEvent event, emit) {
    _profileRepository.addTrip(event.trip);
  }

  _onLoading(AddTripLoadingEvent event, emit) {
    emit(AddTripLoadingState());
  }

  _onSuccess(AddTripSuccessEvent event, emit) {
    emit(AddTripSuccessState());
  }

  _onFail(AddTripFailEvent event, emit) {
    emit(AddTripFailState());
  }

  _onWait(AddTripWaitingEvent event, emit) {
    emit(AddTripWaitingState());
  }
}
