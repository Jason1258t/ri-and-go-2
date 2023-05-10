// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:riandgo2/feature/app/bloc/app_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_login/auth_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_register/register_bloc.dart';
import 'package:riandgo2/feature/auth/ui/ui_login/login_screen.dart';
import 'package:riandgo2/feature/auth/ui/ui_register/registration_screen_first.dart';
import 'package:riandgo2/feature/home/ui/home_page.dart';
import 'package:riandgo2/feature/profile/bloc/profile_bloc.dart';
import 'package:riandgo2/repository/app_repository.dart';
import 'package:riandgo2/services/api_services.dart';

///Рекомендации: советую использовать auto_route (https://pub.dev/packages/auto_route)
///с его возможностью вложенной навигации
///Переход по страницам осуществлять через NavBloc, который так же должен быть подписан
///на стрим isAuth. Переход скорее всего лучше будет осуществлять сразу же из этого файла
///и делать переход через BlocListener для NavBloc (так будет больше контроля за навигацией)

class MyRepositoryProvider extends StatelessWidget {
  const MyRepositoryProvider({Key? key}) : super(key: key);

  /// инициализация единожды и передача в репозитории 1 экземпляра api
  static final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (_) => AppRepository(apiService: apiService)),
        ],
        child: const MyBlocProviders(),
        // child: MyApp(),
      ),
    );
  }
}

class MyBlocProviders extends StatelessWidget {
  const MyBlocProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (_) => AppBloc(
              appRepository: RepositoryProvider.of<AppRepository>(context),
            )..add(SubscripeAppEvent()),
            lazy: false,
          ),
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
              appRepository: RepositoryProvider.of<AppRepository>(context),
            )..add(SubscripeAuthEvent()),
            lazy: false,
          ),
          BlocProvider<RegisterBloc>(
            create: (_) => RegisterBloc(
              appRepository: RepositoryProvider.of<AppRepository>(context),
            )..add(SubscripeRegisterEvent()),
            lazy: false,
          ),
          BlocProvider<ProfileBloc>(
              create: (_) => ProfileBloc(
                  appRepository: RepositoryProvider.of<AppRepository>(context))
                ..add(ProfileSubscribeEvent()))
        ],
        child: const AppStateWidget(),
      ),
    );
  }
}

class AppStateWidget extends StatelessWidget {
  const AppStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is AuthAppState) {
            return MyHomePage();
          } else if (state is UnAuthAppState) {
            return LoginScreen();
          } else if (state is LoadingAppState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
