import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';
import 'package:riandgo2/models/models.dart';

part 'trips_event.dart';

part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final TripsRepository _tripsRepository;
  late StreamSubscription _tripsState;

  TripsBloc(TripsRepository tripsRepository)
      : _tripsRepository = tripsRepository,
        super(TripsInitial()) {
    on<TripsSubscriptionEvent>(_subscribe);
    on<TripsInitialLoadEvent>(_initialLoad);
    on<TripsLoadingEvent>(_onLoading);
    on<TripsSuccessEvent>(_onSuccess);
    on<TripsFailEvent>(_onFail);
    on<TripsSetFilterEvent>(_onSetFilter);
  }

  _subscribe(TripsSubscriptionEvent event, emit) {
    _tripsState = _tripsRepository.tripsState.stream.listen((event) {
      if (event == TripsStateEnum.loading) add(TripsLoadingEvent());
      if (event == TripsStateEnum.success) add(TripsSuccessEvent());
      if (event == TripsStateEnum.fail) add(TripsFailEvent());
    });
  }

  _initialLoad(TripsInitialLoadEvent event, emit) {
    _tripsRepository.loadTips(event.filter, event.necessarily);
  }

  _onLoading(TripsLoadingEvent event, emit) {
    emit(TripsLoadingState());
  }

  _onSuccess(TripsSuccessEvent event, emit) {
    emit(TripsLoadedState());
  }

  _onFail(TripsFailEvent event, emit) {
    emit(TripsFailState());
  }

  _onSetFilter(TripsSetFilterEvent event, emit) {
    log(event.filter.departure ?? 'хуйня');
    _tripsRepository.copyWithFilter(event.filter);
  }
}
