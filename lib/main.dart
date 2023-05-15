// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/app.dart';
import 'package:riandgo2/feature/Trips/bloc/trips_bloc.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';

// Project imports:
import 'package:riandgo2/feature/app/bloc/app_bloc.dart';
import 'package:riandgo2/feature/app/ui/main_screen.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_login/auth_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_register/register_bloc.dart';
import 'package:riandgo2/feature/auth/ui/ui_login/login_screen.dart';
import 'package:riandgo2/feature/auth/ui/ui_register/registration_screen_first.dart';
import 'package:riandgo2/feature/home/ui/home_page.dart';
import 'package:riandgo2/feature/profile/bloc/main_info/profile_bloc.dart';
import 'package:riandgo2/feature/profile/bloc/trips_info/user_trips_bloc.dart';
import 'package:riandgo2/feature/profile/data/profile_repository.dart';
import 'package:riandgo2/feature/profile/ui/profile_screen.dart';
import 'package:riandgo2/repository/app_repository.dart';
import 'package:riandgo2/services/api_services.dart';
import 'package:riandgo2/services/custom_bloc_observer.dart';

import 'feature/addCard/bloc/add_trip_bloc.dart';
import 'feature/app/bloc/navigator_bloc.dart';

Future<void> main() async {
  /// Для хранения дефолтных переменных используется файл .env
  /// можно разделять на .prod.env и .dev.env, например, если|
  /// предполагается разработака на тестовой и боевой среде
  //await dotenv.load(fileName: ".env");

  Bloc.observer = CustomBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyRepositoryProvider();
  }
}

class MyRepositoryProvider extends StatelessWidget {
  const MyRepositoryProvider({Key? key}) : super(key: key);

  /// инициализация единожды и передача в репозитории 1 экземпляра api
  static final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (_) => AppRepository(apiService: apiService)),
        RepositoryProvider(
            create: (_) => ProfileRepository(apiService: apiService)),
        RepositoryProvider(
            create: (_) => TripsRepository(apiService: apiService))
      ],
      child: const MyBlocProviders(),
      // child: MyApp(),
    );
  }
}

class MyBlocProviders extends StatelessWidget {
  const MyBlocProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
            create: (context) => ProfileBloc(
                profileRepository:
                    RepositoryProvider.of<ProfileRepository>(context),
                appRepository: RepositoryProvider.of<AppRepository>(context))
              ..add(ProfileSubscribeEvent())),
        BlocProvider<UserTripsBloc>(
          create: (context) => UserTripsBloc(
              profileRepository:
                  RepositoryProvider.of<ProfileRepository>(context))
            ..add(UserTripsSubscribeEvent()),
          lazy: false,
        ),
        BlocProvider<TripsBloc>(
          create: (_) =>
              TripsBloc(RepositoryProvider.of<TripsRepository>(context))
                ..add(TripsSubscriptionEvent()),
          lazy: false,
        ),
        BlocProvider<AddTripBloc>(
          create: (_) =>
              AddTripBloc(RepositoryProvider.of<ProfileRepository>(context))
                ..add(AddTripSubscribeEvent()),
          lazy: false,
        ),
        BlocProvider<NavigatorBloc>(
          create: (_) =>
          NavigatorBloc(),
          lazy: false,
        )
      ],
      child: const AppStateWidget(),
    );
  }
}

class AppStateWidget extends StatelessWidget {
  const AppStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Nunito',
      ),
      home: Scaffold(
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is AuthAppState) {
              return const MainScreen();
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
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
