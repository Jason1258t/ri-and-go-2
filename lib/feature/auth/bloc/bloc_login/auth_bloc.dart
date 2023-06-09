// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../repository/app_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppRepository _appRepository;
  late final StreamSubscription authStateSubscription;

  AuthBloc({
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        super(AuthInitialState()) {
    on<InitialAuthEvent>(_initialAuthEmit);
    on<LoadingAuthEvent>(_loadingAuthEmit);
    on<SuccessAuthEvent>(_successAuthEmit);
    on<FailAuthEvent>(_failAuthEmit);
    on<SubscripeAuthEvent>(_subscribe);
    on<StartAuthEvent>(_startAuth);
    on<IncorrectlyEmailAuthEvent>(_incorrectlyEmailAuthEmit);
    on<IncorrectlyFieldAuthEvent>(_incorrectlyFieldAuthEmit);
  }

  FutureOr<void> _initialAuthEmit(InitialAuthEvent event, emit) =>
      emit(AuthInitialState());

  FutureOr<void> _loadingAuthEmit(LoadingAuthEvent event, emit) =>
      emit(AuthLoadingState());

  FutureOr<void> _successAuthEmit(SuccessAuthEvent event, emit) =>
      emit(AuthSuccessState());

  FutureOr<void> _failAuthEmit(FailAuthEvent event, emit) =>
      emit(AuthFailState());

  Future<void> _subscribe(SubscripeAuthEvent event, emit) async {
    authStateSubscription =
        _appRepository.authState.stream.listen((AuthStateEnum event) {
      if (event == AuthStateEnum.wait) add(InitialAuthEvent());
      if (event == AuthStateEnum.loading) add(LoadingAuthEvent());
      if (event == AuthStateEnum.success) {
        _appRepository.checkLogin();
        add(SuccessAuthEvent());
      }
      if (event == AuthStateEnum.fail) add(FailAuthEvent());
    });
  }

  FutureOr<void> _incorrectlyEmailAuthEmit(
      IncorrectlyEmailAuthEvent event, emit) {
    if (event.email != 'admin') {
      if (!(RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(event.email))) {
        emit(AuthIncorrectlyEmailState());
      } else {
        emit(AuthCorrectlyEmailState());
      }
    } else {
      emit(AuthCorrectlyEmailState());
    }

  }

  FutureOr<void> _incorrectlyFieldAuthEmit(
      IncorrectlyFieldAuthEvent event, emit) {
    if (event.email == '' && event.password == '') {
      emit(AuthIncorrectlyFieldState());
    } else {
      add(IncorrectlyEmailAuthEvent(email: event.email));
    }
  }

  Future<void> _startAuth(StartAuthEvent event, emit) async {
    await _appRepository.auth(login: event.login, password: event.password);
  }

  @override
  Future<void> close() {
    authStateSubscription.cancel();
    return super.close();
  }
}
