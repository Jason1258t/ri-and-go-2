import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:riandgo2/repository/app_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppRepository _appRepository;
  late final StreamSubscription authStateSubscription;

  ProfileBloc({required AppRepository appRepository})
      : _appRepository = appRepository,
        super(ProfileInitial()) {
    on<ProfileLoadingEvent>(_onLoading);
    on<ProfileLoadedEvent>(_onLoaded);
    on<ProfileErrorEvent>(_onError);
    on<ProfileSubscribeEvent>(_onSubscribe);
    on<ProfileInitialLoadEvent>(_onInitial);
  }

  _onInitial(ProfileInitialLoadEvent event, emit) {
    _appRepository.loadProfile(id: _appRepository.userId ?? 0);
    add(ProfileLoadingEvent());
  }

  _onSubscribe(ProfileSubscribeEvent event, emit) {
    authStateSubscription =
        _appRepository.profileState.stream.listen((ProfileStateEnum event) {
      if (event == ProfileStateEnum.loading) add(ProfileLoadingEvent());
      if (event == ProfileStateEnum.success) {
        print("хуй");
        add(ProfileLoadedEvent());
      }
      if (event == ProfileStateEnum.fail) add(ProfileErrorEvent());
    });
  }

  _onLoading(ProfileLoadingEvent event, Emitter emit) {
    emit(ProfileLoadingState());
  }

  _onLoaded(ProfileLoadedEvent event, emit) {
    emit(ProfileLoadedState(
        name: _appRepository.profileInfo['name'],
        phone: _appRepository.profileInfo['phoneNumber'],
        email: _appRepository.profileInfo['email']));
  }

  _onError(ProfileErrorEvent event, emit) {
    emit(ProfileErrorState());
  }
}
