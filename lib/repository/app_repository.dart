// Package imports:

// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:riandgo2/services/api_services.dart';

///Для стримов использую BehaviorSubject т.к. он сохраняет последние данные внутри себя
///Репозиторий ничего напрямую в блок не передает. Блоки подписаны на стримы.
///Блоки между собой так же общаются только через стримы в репе.
///Реагирование на ошибки так же идет из блоков.
///Можно создать стрим ошибок и подписать блоки на него.

enum AppStateEnum { auth, unAuth, loading }

enum AuthStateEnum { wait, loading, success, fail }

class AppRepository {
  final ApiService apiService;

  /// seeded для установки значения по умолчанию
  BehaviorSubject<String> token = BehaviorSubject<String>.seeded('');
  BehaviorSubject<AppStateEnum> appState =
      BehaviorSubject<AppStateEnum>.seeded(AppStateEnum.unAuth);

  AppRepository({required this.apiService});

  checkLogin() async {
    try {
      appState.add(AppStateEnum.loading);
      await Future.delayed(Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString('auth_token');
      if (authToken != null && authToken.isNotEmpty) {
        token.add(authToken);
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
    token.add('');
    appState.add(AppStateEnum.unAuth);
  }

  BehaviorSubject<AuthStateEnum> authState =
      BehaviorSubject<AuthStateEnum>.seeded(AuthStateEnum.wait);

  Future<void> auth({required String login, required String password}) async {
    try {
      authState.add(AuthStateEnum.loading);
      final authToken =
          await apiService.loginUser(login: login, password: password);

      await Future.delayed(Duration(seconds: 3));
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('auth_token', 'any_auth_token');
      authState.add(AuthStateEnum.success);
    } catch (e) {
      authState.add(AuthStateEnum.fail);
      throw e;
    }
  }
}
