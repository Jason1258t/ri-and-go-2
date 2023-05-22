import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';

part 'follow_event.dart';

part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final TripsRepository _tripRepository;
  late StreamSubscription _followingState;

  FollowBloc({required TripsRepository tripsRepository})
      : _tripRepository = tripsRepository,
        super(FollowInitial()) {
    on<FollowSubscriptionEvent>(_subscribe);
    on<FollowInitialEvent>(_onFollow);
    on<FollowProcessingEvent>(_onFollowProcessing);
    on<FollowSuccessEvent>(_onFollowSuccess);
    on<FollowFailEvent>(_onFollowFail);
    on<FollowAlreadyAvailableEvent>(_onAlreadyFollow);
    on<UnFollowInitialEvent>(_onUnFollow);
  }

  _subscribe(FollowSubscriptionEvent event, emit) {
    _followingState = _tripRepository.followState.stream.listen((event) {
      if (event == FollowingStateEnum.loading) add(FollowProcessingEvent());
      if (event == FollowingStateEnum.success) add(FollowSuccessEvent());
      if (event == FollowingStateEnum.fail) add(FollowFailEvent());
    });
  }

  _onFollow(FollowInitialEvent event, emit) {
    _tripRepository.followTrip(event.tripId, event.userId);
  }
  _onUnFollow(UnFollowInitialEvent event, emit) {
    _tripRepository.unFollowTrip(tripId: event.tripId, userId: event.userId);
  }

  _onFollowProcessing(FollowProcessingEvent event, emit) {
    emit(FollowProcessingState());
  }

  _onFollowSuccess(FollowSuccessEvent event, emit) {
    emit(FollowSuccessState());
  }

  _onFollowFail(FollowFailEvent event, emit) {
    emit(FollowFailState());
  }

  _onAlreadyFollow(FollowAlreadyAvailableEvent event, emit) {
    emit(FollowAlreadyAvailableState());
  }
}
