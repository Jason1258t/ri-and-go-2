import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  bool checkFields() =>
      _emailController.text != '' && _phoneController.text != '';

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
                if (state is CorrectFirstScreen) {
                  bloc.add(CollectingRegistrationInfoEvent(
                    email: _emailController.text,
                    phone: _phoneController.text,
                  ));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SecondRegistrationScreen(),
                      ));
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
                        const SizedBox(height: 100),
                        Image.asset("Assets/logo.png"),
                        const SizedBox(height: 20),
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
                          prefixIcon:
                              const Icon(Icons.email_outlined, size: 19),
                          outlineColor: (state is InvalidFirstScreenState)?  ((!state.email)? Colors.red : AppColors.lightGrey) : AppColors.lightGrey,
                        ),
                        BaseTextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          obscureText: false,
                          hintText: 'phone',
                          prefixIcon: const Icon(Icons.phone, size: 19),
                          outlineColor: (state is InvalidFirstScreenState)?  ((!state.phone)? Colors.red : AppColors.lightGrey) : AppColors.lightGrey,
                        ),
                        const SizedBox(height: 90),
                        DefaultElevatedButton(
                          title: 'Далее',
                          onPressed: () {
                            if (checkFields()) {
                              bloc.add(FirstScreenCorrectCheckFieldsEvent(
                                email: _emailController.text,
                                phone: _phoneController.text,));
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
