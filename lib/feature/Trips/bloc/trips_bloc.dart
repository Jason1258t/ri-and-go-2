import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:riandgo2/models/models.dart';

part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  TripsBloc() : super(TripsInitial()) {
    on<TripsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
