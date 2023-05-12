import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:riandgo2/feature/profile/data/profile_repository.dart';
import 'package:riandgo2/repository/app_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  final AppRepository _appRepository;
  late final StreamSubscription profileStateSubscription;
  late final StreamSubscription profileEditingStateSubscription;

  ProfileBloc(
      {required ProfileRepository profileRepository,
      required AppRepository appRepository})
      : _profileRepository = profileRepository,
        _appRepository = appRepository,
        super(ProfileInitial()) {
    on<ProfileLoadingEvent>(_onLoading);
    on<ProfileLoadedEvent>(_onLoaded);
    on<ProfileErrorEvent>(_onError);
    on<ProfileSubscribeEvent>(_onSubscribe);
    on<ProfileInitialLoadEvent>(_onInitial);
    on<ProfileEditInitialEvent>(_onEditInitial);
    on<ProfileEditSuccessEvent>(_onEditSuccess);
    on<ProfileEditLoadingEvent>(_onEditLoading);
    on<ProfileEditFailEvent>(_onEditFail);
  }

  _onInitial(ProfileInitialLoadEvent event, emit) {
    try {
      _profileRepository.userId = _appRepository.getUserId() ?? -1;
      _profileRepository.loadProfile();
      add(ProfileLoadingEvent());
    } catch (e) {
      add(ProfileErrorEvent());
      rethrow;
    }
  }

  _onSubscribe(ProfileSubscribeEvent event, emit) {
    profileStateSubscription =
        _profileRepository.profileState.stream.listen((ProfileStateEnum event) {
      if (event == ProfileStateEnum.loading) add(ProfileLoadingEvent());
      if (event == ProfileStateEnum.success) add(ProfileLoadedEvent());
      if (event == ProfileStateEnum.fail) add(ProfileErrorEvent());
    });

    profileEditingStateSubscription = _profileRepository.profileEditState.stream
        .listen((ProfileEditingStateEnum event) {
      if (event == ProfileEditingStateEnum.loading) add(ProfileEditLoadingEvent());
      if (event == ProfileEditingStateEnum.success) add(ProfileEditSuccessEvent());
      if (event == ProfileEditingStateEnum.fail) add(ProfileEditFailEvent());
    });
  }

  _onLoading(ProfileLoadingEvent event, Emitter emit) {
    emit(ProfileLoadingState());
  }

  _onLoaded(ProfileLoadedEvent event, emit) {
    emit(ProfileLoadedState(
        name: _profileRepository.userInfo.name,
        phone: _profileRepository.userInfo.phoneNumber,
        email: _profileRepository.userInfo.email));
  }

  _onError(ProfileErrorEvent event, emit) {
    emit(ProfileErrorState());
  }

  _onEditInitial(ProfileEditInitialEvent event, emit) {
    Map data = {
      'name': event.name,
      'email': event.email,
      'phoneNumber': event.phoneNumber,
      'contactUrl': event.contactUrl,
      'id': _appRepository.userId,
      'password': _appRepository.userPassword
    };

    _profileRepository.editProfile(data);
  }

  _onEditLoading(ProfileEditLoadingEvent event, emit) {
    emit(ProfileEditLoadingState());
  }

  _onEditSuccess(ProfileEditSuccessEvent event, emit) {
    emit(ProfileEditSuccessState(
        name: _profileRepository.userInfo.name,
        email: _profileRepository.userInfo.email,
        phoneNumber: _profileRepository.userInfo.phoneNumber,
        contactUrl: _profileRepository.userInfo.contactUrl));
  }

  _onEditFail(ProfileEditFailEvent event, emit) {
    emit(ProfileEditFailState());
  }
}
