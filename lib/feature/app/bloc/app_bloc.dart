// Dart imports:
import 'dart:async';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/app_repository.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository _appRepository;
  late final StreamSubscription appStateSubscription;

  AppBloc({required AppRepository appRepository})
      : _appRepository = appRepository,
        super(InitialAppState()) {
    on<SubscripeAppEvent>(_subscribe);
    on<AuthAppEvent>(_authEmit);
    on<UnAuthAppEvent>(_unAuthEmit);
    on<LoadingAppEvent>(_loadingEmit);
    on<LogoutAppEvent>(_logout);
    on<RegisterAppEvent>(_registerEmit);
  }

  Future<void> _subscribe(SubscripeAppEvent event, emit) async {
    _appRepository.checkLogin();
    appStateSubscription =
        _appRepository.appState.stream.listen((AppStateEnum event) {
      if (event == AppStateEnum.auth) add(AuthAppEvent());
      if (event == AppStateEnum.unAuth) add(UnAuthAppEvent());
      if (event == AppStateEnum.loading) add(LoadingAppEvent());
      if (event == AppStateEnum.registered) add(RegisterAppEvent());
    });
  }

  FutureOr<void> _authEmit(AuthAppEvent event, emit) => emit(AuthAppState());
  FutureOr<void> _registerEmit(RegisterAppEvent event, emit) => emit(RegisteredAppState());

  FutureOr<void> _unAuthEmit(UnAuthAppEvent event, emit) => emit(UnAuthAppState());

  FutureOr<void> _loadingEmit(LoadingAppEvent event, emit) => emit(LoadingAppState());

  Future<void> _logout(LogoutAppEvent event, emit) async => await _appRepository.logout();

  @override
  Future<void> close() {
    appStateSubscription.cancel();
    return super.close();
  }
}
