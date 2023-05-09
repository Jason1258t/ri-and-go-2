import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_login/auth_bloc.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_register/register_bloc.dart';
import 'package:riandgo2/feature/auth/ui/ui_register/registration_screen_second.dart';
import 'package:riandgo2/utils/dialogs.dart';
import 'package:riandgo2/utils/utils.dart';
import 'package:riandgo2/widgets/buttons/default_elevated_button.dart';
import 'package:riandgo2/widgets/text_fields/base_text_form_field.dart';

import '../../../../widgets/buttons/default_text_button.dart';

class FirstRegistrationScreen extends StatelessWidget {
  FirstRegistrationScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool checkFields() =>  _emailController.text != '' && _phoneController.text != '';

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RegisterBloc>(context);
    return SafeArea(
      child: Scaffold(
          body: BlocConsumer<RegisterBloc, RegisterState>(
              //create: (context) => bloc,
              listener: (context, state) {
                log(state.toString(), name: 'BlocConsumer state');
                Dialogs.hide(context);
                if (state is RegisterInitialState) {}
                if (state is RegisterLoadingState) {
                  Dialogs.showModal(
                      context,
                      const Center(
                        child: CircularProgressIndicator(),
                      ));
                }
                if (state is RegisterSuccessState) {
                  const snackBar = SnackBar(
                    content: Text('reg complete'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (state is RegisterFailState) {
                  const snackBar = SnackBar(
                    content: Text('reg fail'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) => SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DefaultTextButton(
                                title: 'вход',
                                width: 100,
                                height: 40,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                textStyle: AppTypography.font17grey)
                          ],
                        ),
                        SizedBox(height: 100),
                        Image.asset("Assets/logo.png"),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultTextButton(
                              width: 150,
                              height: 60,
                              title: 'Регистрация',
                              textStyle: AppTypography.font20grey,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        BaseTextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'email',
                          prefixIcon: const Icon(Icons.email_outlined, size: 19),
                        ),
                        BaseTextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          obscureText: false,
                          hintText: 'phone',
                          prefixIcon: const Icon(Icons.phone, size: 19),
                        ),
                        const SizedBox(height: 90),
                        DefaultElevatedButton(
                          title: 'Далее',
                          onPressed: () {
                            if (checkFields()) {
                              bloc.add(CollectingRegistrationInfoEvent(
                                email: _emailController.text,
                                phone: _phoneController.text,
                              ));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                            value: bloc,
                                            child: SecondRegistrationScreen(),
                                          )));
                            } else {
                              const snackBar = SnackBar(
                                content: Text('поля не заполнены'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                        ),
                      ],
                    ),
                  ))),
    );
  }
}
