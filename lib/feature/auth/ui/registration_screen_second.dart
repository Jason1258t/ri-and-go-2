import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/auth_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/register_bloc.dart';
import 'package:riandgo2/utils/dialogs.dart';
import 'package:riandgo2/widgets/buttons/default_elevated_button.dart';
import 'package:riandgo2/widgets/text_fields/base_text_form_field.dart';

class SecondRegistrationScreen extends StatelessWidget {
  SecondRegistrationScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RegisterBloc>(context);
    return Scaffold(
        body: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            // TODO: implement listener
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
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'name',
                    prefixIcon: const Icon(Icons.email_outlined, size: 19),
                  ),
                  BaseTextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    hintText: 'password',
                    prefixIcon: const Icon(Icons.lock_outline, size: 19),
                  ),
                  const SizedBox(height: 90),
                  DefaultElevatedButton(
                    title: 'далее',
                    onPressed: () {
                      bloc.add(StartRegisterEvent(
                        name: _nameController.text,
                        password: _passwordController.text,
                      ));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => BlocProvider.value(
                      //             value: bloc, child: Text('fewfwe'))));
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }
}
