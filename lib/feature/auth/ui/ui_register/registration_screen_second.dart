import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_login/auth_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_register/register_bloc.dart';
import 'package:riandgo2/feature/home/ui/home_page.dart';
import 'package:riandgo2/utils/dialogs.dart';
import 'package:riandgo2/utils/utils.dart';
import 'package:riandgo2/widgets/buttons/default_elevated_button.dart';
import 'package:riandgo2/widgets/buttons/small_text_button.dart';
import 'package:riandgo2/widgets/text_fields/base_text_form_field.dart';

import '../../../../widgets/text_fields/base_password_field.dart';

class SecondRegistrationScreen extends StatelessWidget {
  SecondRegistrationScreen({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordControllerFirst = TextEditingController();
  final TextEditingController _passwordControllerSecond = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RegisterBloc>(context);
    return Scaffold(
        body: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
              if (state is RegisterSuccessState) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
              }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Image.asset("Assets/logo.png"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultTextButton(
                        width: 150,
                        height: 60,
                        title: 'Регестрация',
                        textStyle: AppTypography.font20grey,
                        onPressed: () { },
                      ),
                    ],
                  ),
                  BaseTextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'name',
                    prefixIcon: const Icon(Icons.email_outlined, size: 19),
                  ),
                  BasePasswordField(
                    controller: _passwordControllerFirst,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'password',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 19,
                    ),
                  ),
                  BasePasswordField(
                    controller: _passwordControllerSecond,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'password',
                    prefixIcon: const Icon(Icons.lock_outline, size: 19),
                  ),
                  const SizedBox(height: 90),
                  DefaultElevatedButton(
                    title: 'далее',
                    onPressed: () {
                      bloc.add(CollectingRegistrationInfoEvent(name: _nameController.text, password: _passwordControllerFirst.text));
                      bloc.add(StartRegisterEvent(password: bloc.state.password, email: bloc.state.email, name: bloc.state.name, phone: bloc.state.phone,));
                    },
                  ),
                  DefaultElevatedButton(
                    title: 'назад',
                    onPressed: () {
                      bloc.add(CollectingRegistrationInfoEvent(name: _nameController.text, password: _passwordControllerFirst.text));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }
}
