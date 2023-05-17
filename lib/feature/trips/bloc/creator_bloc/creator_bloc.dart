import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';

part 'creator_event.dart';

part 'creator_state.dart';

class CreatorBloc extends Bloc<CreatorEvent, CreatorState> {
  final TripsRepository _tripsRepository;
  late StreamSubscription creatorState;

  CreatorBloc({required TripsRepository tripsRepository})
      : _tripsRepository = tripsRepository,
        super(CreatorInitial()) {
    on<CreatorLoadingEvent>(_onLoading);
    on<CreatorInitialLoadEvent>(_onInitialLoad);
    on<CreatorSubscribeEvent>(_onSubscribe);
    on<CreatorSuccessEvent>(_onSuccess);
    on<CreatorFailEvent>(_onFail);
  }

  _onWaiting(CreatorWaitEvent event, emit) {
    emit(CreatorWaitingState());
  }

  _onLoading(CreatorLoadingEvent event, emit) {
    emit(CreatorLoadingState());
  }

  _onInitialLoad(CreatorInitialLoadEvent event, emit) {
    _tripsRepository.loadCreator(event.userId);
  }

  _onSuccess(CreatorSuccessEvent event, emit) {
    emit(CreatorSuccessState(
      name: _tripsRepository.creatorInfo.name,
      email: _tripsRepository.creatorInfo.email,
      phone: _tripsRepository.creatorInfo.phoneNumber,
      contactUrl: _tripsRepository.creatorInfo.contactUrl,
    ));
  }

  _onFail(CreatorFailEvent event, emit) {
    emit(CreatorFailState());
  }

  _onSubscribe(CreatorSubscribeEvent event, emit) {
    creatorState = _tripsRepository.creatorState.stream.listen((event) {
      if (event == CreatorStateEnum.loading) add(CreatorLoadingEvent());
      if (event == CreatorStateEnum.success) add(CreatorSuccessEvent());
      if (event == CreatorStateEnum.fail) add(CreatorFailEvent());
    });
  }
}
