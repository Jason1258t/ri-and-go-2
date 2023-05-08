// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../repository/app_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AppRepository _appRepository;
  late final StreamSubscription authStateSubscription;

  RegisterBloc({
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        super(RegisterInitialState()) {
    on<StartRegisterEvent>(_startRegistration);
    on<CollectingRegistrationInfoEvent>(_addRegisterInfo);
    on<SuccessRegisterEvent>(_successRegisterEmit);
    on<RegisterLoadingEvent>(_addRegisterLoading);
    on<RegisterFailEvent>(_addRegisterFail);
  }

  Future<void> _startRegistration(
      StartRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(password: event.password, name: event.name));
    await _appRepository.register(
        login: state.email,
        password: event.password,
        phone: state.phone,
        name: event.name);
    await _appRepository.auth(login: state.email, password: event.password);
  }

  _successRegisterEmit(SuccessRegisterEvent event, emit) =>
      emit(RegisterSuccessState());

  _addRegisterInfo(
      CollectingRegistrationInfoEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email, phone: event.phone));
  }

  _addRegisterFail(RegisterFailEvent event, Emitter<RegisterState> emit) {
    emit(RegisterFailState());
  }
  _addRegisterLoading(RegisterLoadingEvent event, Emitter<RegisterState> emit) {
    emit(RegisterLoadingState());
  }

  @override
  Future<void> close() {
    authStateSubscription.cancel();
    return super.close();
  }
}
