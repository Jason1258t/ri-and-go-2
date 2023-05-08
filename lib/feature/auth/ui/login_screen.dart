// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:riandgo2/feature/auth/bloc/auth_bloc.dart';
import 'package:riandgo2/utils/dialogs.dart';
import 'package:riandgo2/widgets/buttons/default_elevated_button.dart';
import 'package:riandgo2/widgets/text_fields/base_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          log(state.toString(), name: 'BlocConsumer state');
          Dialogs.hide(context);
          if (state is AuthInitialState) {

          }
          if (state is AuthLoadingState) {
            Dialogs.showModal(
                context,
                Center(
                  child: CircularProgressIndicator(),
                ));
          }
          if (state is AuthSuccessState) {
            const snackBar = SnackBar(
              content: Text('Auth complete'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is AuthFailState) {
            const snackBar = SnackBar(
              content: Text('Auth fail'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                FlutterLogo(size: 150),
                SizedBox(height: 100),
                BaseTextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'email',
                ),
                BaseTextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  hintText: 'password',
                ),
                DefaultElevatedButton(
                  title: 'Логин',
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(StartAuthEvent(
                      login: _emailController.text,
                      password: _passwordController.text,
                    ));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
