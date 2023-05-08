import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/auth_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/register_bloc.dart';
import 'package:riandgo2/utils/dialogs.dart';
import 'package:riandgo2/widgets/buttons/default_elevated_button.dart';
import 'package:riandgo2/widgets/text_fields/base_text_form_field.dart';

class FirstRegistrationScreen extends StatelessWidget {
  FirstRegistrationScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          log(state.toString(), name: 'BlocConsumer state');
          Dialogs.hide(context);
          if (state is AuthInitialState) {}
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
                Image.asset("Assets/logo.png"),
                SizedBox(height: 100),
                BaseTextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'email',
                  prefixIcon: const Icon(Icons.email_outlined, size: 19),
                ),
                BaseTextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  hintText: 'phone',
                  prefixIcon: const Icon(Icons.lock_outline, size: 19),
                ),
                const SizedBox(height: 90),
                DefaultElevatedButton(
                  title: 'далее',
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(StartAuthEvent(
                      login: _emailController.text,
                      password: _phoneController.text,
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
