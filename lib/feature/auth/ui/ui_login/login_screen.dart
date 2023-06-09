// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:riandgo2/feature/auth/bloc/bloc_login/auth_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_register/register_bloc.dart';
import 'package:riandgo2/feature/auth/ui/ui_register/registration_screen_first.dart';
import 'package:riandgo2/utils/animations.dart';
import 'package:riandgo2/utils/dialogs.dart';
import 'package:riandgo2/utils/utils.dart';
import 'package:riandgo2/widgets/buttons/default_elevated_button.dart';
import 'package:riandgo2/widgets/buttons/default_text_button.dart';
import 'package:riandgo2/widgets/alerts/custom_snack_bar.dart';
import 'package:riandgo2/widgets/text_fields/base_password_field.dart';
import 'package:riandgo2/widgets/text_fields/base_text_form_field.dart';

import '../../../app/ui/main_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool checkFields() =>
      _emailController.text != '' && _passwordController.text != '';

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RegisterBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            log(state.toString(), name: 'BlocConsumer state');
            Dialogs.hide(context);
            if (state is AuthInitialState) {}
            if (state is AuthLoadingState) {
              Dialogs.showModal(
                  context,
                  Center(
                    child: AppAnimations.bouncingLine,
                  ));
            }
            if (state is AuthSuccessState) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const MainScreen()));
            }
            if (state is AuthFailState) {
              CustomSnackBar.showSnackBar(context, 'Что-то пошло не так');
            }
            if (state is AuthIncorrectlyFieldState) {
              CustomSnackBar.showSnackBar(context, 'Поля не заполнены');
            } else {
              if (state is AuthCorrectlyEmailState) {
                authBloc.add(StartAuthEvent(
                    login: _emailController.text,
                    password: _passwordController.text));
              }
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset("Assets/logo.png"),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultTextButton(
                        width: 150,
                        height: 60,
                        title: 'Вход',
                        textStyle: AppTypography.font20grey,
                        onPressed: () {},
                      ),
                      DefaultTextButton(
                        width: 150,
                        height: 60,
                        textStyle: AppTypography.font20orange,
                        title: 'Регистрация',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: bloc,
                                        child: FirstRegistrationScreen(),
                                      )));
                        },
                      )
                    ],
                  ),
                  BaseTextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'email',
                    prefixIcon: const Icon(Icons.email_outlined, size: 19),
                    outlineColor: (state is AuthIncorrectlyEmailState)? Colors.red : AppColors.lightGrey,
                  ),
                  BasePasswordField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'password',
                    prefixIcon: const Icon(Icons.lock_outline, size: 19),
                  ),
                  const SizedBox(height: 90),
                  DefaultElevatedButton(
                    title: 'Войти',
                    onPressed: () {
                      authBloc.add(IncorrectlyFieldAuthEvent(
                          email: _emailController.text,
                          password: _passwordController.text));
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
