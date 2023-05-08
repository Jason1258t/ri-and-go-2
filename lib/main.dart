// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:riandgo2/app.dart';
import 'package:riandgo2/services/custom_bloc_observer.dart';

Future<void> main() async {
  /// Для хранения дефолтных переменных используется файл .env
  /// можно разделять на .prod.env и .dev.env, например, если
  /// предполагается разработака на тестовой и боевой среде
  //await dotenv.load(fileName: ".env");

  Bloc.observer = CustomBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Nunito',
      ),
      home: const MyRepositoryProvider(),
      debugShowCheckedModeBanner: false,
    );
  }
}
