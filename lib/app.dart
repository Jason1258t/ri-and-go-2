// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';

// Project imports:
import 'package:riandgo2/feature/app/bloc/app_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_login/auth_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_register/register_bloc.dart';
import 'package:riandgo2/feature/auth/data/registration_repository.dart';
import 'package:riandgo2/feature/auth/ui/ui_login/login_screen.dart';
import 'package:riandgo2/feature/profile/bloc/main_info/profile_bloc.dart';
import 'package:riandgo2/feature/profile/bloc/trips_info/user_trips_bloc.dart';
import 'package:riandgo2/feature/profile/data/profile_repository.dart';
import 'package:riandgo2/feature/profile/ui/profile_screen.dart';
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
          RepositoryProvider(
              create: (_) => ProfileRepository(apiService: apiService))
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
              registrationRepository: RepositoryProvider.of<RegistrationRepository>(context),
            )..add(SubscripeRegisterEvent()),
            lazy: false,
          ),
          BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(
                  profileRepository:
                      RepositoryProvider.of<ProfileRepository>(context),
                  tripsRepository: RepositoryProvider.of<TripsRepository>(context),
                  appRepository: RepositoryProvider.of<AppRepository>(context))
                ..add(ProfileSubscribeEvent())),
          BlocProvider<UserTripsBloc>(
              create: (context) => UserTripsBloc(
                  profileRepository:
                      RepositoryProvider.of<ProfileRepository>(context))
                ..add(UserTripsSubscribeEvent()))
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
            return const Profile();
          } else if (state is UnAuthAppState) {
            return LoginScreen();
          } else if (state is LoadingAppState) {
            return const Center(
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
