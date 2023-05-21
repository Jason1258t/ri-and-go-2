// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:riandgo2/feature/auth/data/registration_repository.dart';

import '../../../../repository/app_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AppRepository _appRepository;
  final RegistrationRepository _registrationRepository;
  late final StreamSubscription registerStateSubscription;

  RegisterBloc({
    required AppRepository appRepository,
    required RegistrationRepository registrationRepository,
  })  : _appRepository = appRepository,
        _registrationRepository = registrationRepository,
        super(RegisterInitialState()) {
    on<StartRegisterEvent>(_startRegistration);
    on<CollectingRegistrationInfoEvent>(_addRegisterInfo);
    on<SuccessRegisterEvent>(_successRegisterEmit);
    on<RegisterLoadingEvent>(_addRegisterLoading);
    on<RegisterFailEvent>(_addRegisterFail);
    on<SubscripeRegisterEvent>(_subscribe);
    on<FirstScreenCorrectCheckFieldsEvent>(_validEmailAndPhone);
    on<SecondScreenCorrectCheckFieldsEvent>(_validNameAndPassword);
  }

  Future<void> _subscribe(SubscripeRegisterEvent event, emit) async {
    registerStateSubscription =
        _appRepository.authState.stream.listen((AuthStateEnum event) {
      if (event == AuthStateEnum.wait) add(InitialRegisterEvent());
      if (event == AuthStateEnum.loading) add(RegisterLoadingEvent());
      if (event == AuthStateEnum.success) {
        _appRepository.checkLogin();
        add(SuccessRegisterEvent());
      }
      if (event == AuthStateEnum.fail) add(RegisterFailEvent());
    });
  }

  Future<void> _startRegistration(
      StartRegisterEvent event, Emitter<RegisterState> emit) async {
    await _appRepository.register(regInfo: _registrationRepository.getRegInfo());
    //await _appRepository.auth(login: state.email, password: event.password);
  }

  _successRegisterEmit(SuccessRegisterEvent event, emit) =>
      emit(RegisterSuccessState());

  _addRegisterInfo(
      CollectingRegistrationInfoEvent event, Emitter<RegisterState> emit) {
    _registrationRepository.addRegInfo(
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password);
  }

  _addRegisterFail(RegisterFailEvent event, Emitter<RegisterState> emit) {
    emit(RegisterFailState());
  }

  _addRegisterLoading(RegisterLoadingEvent event, Emitter<RegisterState> emit) {
    emit(RegisterLoadingState());
  }

  _validEmailAndPhone(FirstScreenCorrectCheckFieldsEvent event, emit) {
    // final email = _registrationRepository.getRegInfo().email!;
    // final phone = _registrationRepository.getRegInfo().phone!;

    final email = event.email;
    final phone = event.phone;

    bool emailValid = false;
    bool phoneValid = false;
    if ((RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email))) {
      emailValid = true;
    }
    if (RegExp(r'^(\+7|8)\d{10}$').hasMatch(phone)) {
      phoneValid = true;
    }

    if (!emailValid || !phoneValid) {
      emit(InvalidFirstScreenState(phone: phoneValid, email: emailValid));
    } else {
      emit(CorrectFirstScreen());
    }
  }

  _validNameAndPassword(SecondScreenCorrectCheckFieldsEvent event, emit) {
    bool nameValid = false;
    bool passwordValid = false;

    if (event.name.isNotEmpty) nameValid = true;
    if (event.firstPassword == event.secondPassword) passwordValid = true;

    if (!nameValid || !passwordValid) {
      emit(InvalidSecondScreenState(name: nameValid, password: passwordValid));
    } else {
      emit(CorrectSecondScreen());
    }
  }

  @override
  Future<void> close() {
    registerStateSubscription.cancel();
    return super.close();
  }
}
