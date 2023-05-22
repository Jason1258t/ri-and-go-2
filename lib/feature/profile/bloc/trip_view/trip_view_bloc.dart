import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trip_view_event.dart';
part 'trip_view_state.dart';

class TripViewBloc extends Bloc<TripViewEvent, TripViewState> {
  TripViewBloc() : super(TripViewInitial()) {
    on<TripViewInitialLoadEvent>(_onInitialLoad);
    on<TripViewLoadingEvent>(_onLoading);
    on<TripViewSuccessEvent>(_onSuccess);
    on<TripViewFailEvent>(_onFail);
  }

  _onInitialLoad(TripViewInitialLoadEvent event, emit) {

  }

  _onLoading(TripViewLoadingEvent event, emit) {
    emit(TripViewLoadingState());
  }

  _onSuccess(TripViewSuccessEvent event, emit) {
    emit(TripViewSuccessLoadState());
  }

  _onFail(TripViewFailEvent event, emit) {
    emit(TripViewFailLoadState());
  }
}
