// Package imports:

// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:riandgo2/services/api_services.dart';

import '../feature/auth/data/registration_repository.dart';

///Для стримов использую BehaviorSubject т.к. он сохраняет последние данные внутри себя
///Репозиторий ничего напрямую в блок не передает. Блоки подписаны на стримы.
///Блоки между собой так же общаются только через стримы в репе.
///Реагирование на ошибки так же идет из блоков.
///Можно создать стрим ошибок и подписать блоки на него.

enum AppStateEnum { auth, unAuth, loading }

enum AuthStateEnum { wait, loading, success, fail }


class AppRepository {
  final ApiService apiService;

  BehaviorSubject<String> token = BehaviorSubject<String>.seeded('');
  BehaviorSubject<AppStateEnum> appState =
      BehaviorSubject<AppStateEnum>.seeded(AppStateEnum.unAuth);

  AppRepository({required this.apiService});

  String? userPassword;
  int? userId;

  checkLogin() async {
    try {
      appState.add(AppStateEnum.loading);
      await Future.delayed(const Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString('auth_token');
      final id = prefs.getInt('id') ?? 0;
      if (authToken != null && authToken.isNotEmpty && id != 0) {
        token.add(authToken);
        userId = id;
        userPassword = prefs.getString('password');
        appState.add(AppStateEnum.auth);
      } else {
        appState.add(AppStateEnum.unAuth);
      }
    } catch (e) {
      logout();
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    userId = null;
    token.add('');
    appState.add(AppStateEnum.unAuth);
  }

  BehaviorSubject<AuthStateEnum> authState =
      BehaviorSubject<AuthStateEnum>.seeded(AuthStateEnum.wait);

  Future<void> auth({required String login, required String password}) async {
    try {
      authState.add(AuthStateEnum.loading);
      final authToken =
          await apiService.loginUser(email: login, password: password);

      if (authToken == -1) {
        authState.add(AuthStateEnum.fail);
        return;
      }

      await Future.delayed(const Duration(seconds: 3));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', 'any_auth_token');
      await prefs.setInt('id', authToken);
      await prefs.setString('password', password);
      userId = authToken;
      authState.add(AuthStateEnum.success);
    } catch (e) {
      authState.add(AuthStateEnum.fail);
      rethrow;
    }
  }

  Future<void> register(
      {required RegistrationInfo regInfo}) async {
    try {
      authState.add(AuthStateEnum.loading);
      final registration = await apiService.registerUser(
          regInfo: regInfo);

      await Future.delayed(const Duration(seconds: 3));
      if (registration) {
        final registrationData =
            await apiService.loginUser(email: regInfo.email!, password: regInfo.password!);
        await Future.delayed(const Duration(seconds: 3));
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('auth_token', 'any_auth_token');
        prefs.setInt('id', registrationData);
        await prefs.setString('password', regInfo.password!);
        userId = registrationData;
        authState.add(AuthStateEnum.success);
      }
    } catch (e) {
      authState.add(AuthStateEnum.fail);
      rethrow;
    }
  }

  int? getUserId() {
    return userId;
  }

}
