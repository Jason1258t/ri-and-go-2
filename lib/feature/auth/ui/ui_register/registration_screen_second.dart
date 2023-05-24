import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/app/ui/main_screen.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_register/register_bloc.dart';
import 'package:riandgo2/feature/auth/data/registration_repository.dart';
import 'package:riandgo2/feature/carusel_slider/carusel.dart';
import 'package:riandgo2/utils/animations.dart';
import 'package:riandgo2/utils/utils.dart';
import 'package:riandgo2/widgets/alerts/custom_snack_bar.dart';
import 'package:riandgo2/widgets/buttons/default_elevated_button.dart';
import 'package:riandgo2/widgets/buttons/default_text_button.dart';
import 'package:riandgo2/widgets/text_fields/base_text_form_field.dart';

import '../../../../widgets/text_fields/base_password_field.dart';

class SecondRegistrationScreen extends StatelessWidget {
  SecondRegistrationScreen({Key? key}) : super(key: key);
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordControllerFirst = TextEditingController();
  TextEditingController _passwordControllerSecond = TextEditingController();

  bool checkFields() =>
      _nameController.text != '' &&
      _passwordControllerFirst.text != '' &&
      _passwordControllerSecond.text != '';

  bool checkPassword() =>
      _passwordControllerFirst.text == _passwordControllerSecond.text;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RegisterBloc>(context);
    final regRepository =
        RepositoryProvider.of<RegistrationRepository>(context);
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is CorrectSecondScreen) {
                bloc.add(CollectingRegistrationInfoEvent(
                    name: _nameController.text,
                    password: _passwordControllerFirst.text));
                bloc.add(StartRegisterEvent());
              }
              if (state is RegisterLoadingState) {
                showDialog(context: context, builder: (_) =>  AlertDialog(content: AppAnimations.bouncingLine,));
              }
              if (state is RegisterSuccessState) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MainCarousel()));
              }
            },
            builder: (context, state) {
              _nameController.text = regRepository.getRegInfo().name ?? '';
              _passwordControllerFirst.text =
                  regRepository.getRegInfo().password ?? '';
              _passwordControllerSecond.text =
                  regRepository.getRegInfo().password ?? '';
              return Center(
                 child: SingleChildScrollView(
                   child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("Assets/logo.png"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DefaultTextButton(
                                width: 150,
                                height: 60,
                                title: 'Регестрация',
                                textStyle: AppTypography.font20grey,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          BaseTextFormField(
                            controller: _nameController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'name',
                            prefixIcon: const Icon(Icons.email_outlined, size: 19),
                            outlineColor: (state is InvalidSecondScreenState)
                                ? ((!state.name) ? Colors.red : AppColors.lightGrey)
                                : AppColors.lightGrey,
                          ),
                          BasePasswordField(
                            controller: _passwordControllerFirst,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: 'password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              size: 19,
                            ),
                            outlineColor: (state is InvalidSecondScreenState)
                                ? ((!state.password) ? Colors.red : AppColors.lightGrey)
                                : AppColors.lightGrey,
                          ),
                          BasePasswordField(
                            controller: _passwordControllerSecond,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: 'password',
                            prefixIcon: const Icon(Icons.lock_outline, size: 19),
                            outlineColor: (state is InvalidSecondScreenState)
                                ? ((!state.password) ? Colors.red : AppColors.lightGrey)
                                : AppColors.lightGrey,
                          ),
                          const SizedBox(height: 90),
                          DefaultElevatedButton(
                            title: 'Зарегистрироваться',
                            onPressed: () {
                              if (checkFields()) {
                                bloc.add(SecondScreenCorrectCheckFieldsEvent(
                                    name: _nameController.text,
                                    firstPassword: _passwordControllerFirst.text,
                                    secondPassword: _passwordControllerSecond.text));
                              } else {
                                CustomSnackBar.showSnackBar(context, 'Что-то пошло не так');
                              }
                            },
                          ),
                          DefaultTextButton(
                            textStyle: AppTypography.font20orange,
                            title: 'назад',
                            onPressed: () {
                              bloc.add(CollectingRegistrationInfoEvent(
                                  name: _nameController.text,
                                  password: _passwordControllerFirst.text));
                              Navigator.pop(context);
                            },
                          ),
                        ],
                    ),
                 ),
              );
            },
          )),
    );
  }
}
