import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/app/ui/main_screen.dart';
import 'package:riandgo2/feature/auth/bloc/bloc_register/register_bloc.dart';
import 'package:riandgo2/utils/utils.dart';
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

  bool checkPassword() =>  _passwordControllerFirst.text == _passwordControllerSecond.text;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RegisterBloc>(context);
    return SafeArea(
      child: Scaffold(
          body: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const MainScreen()));
              }
            },
            builder: (context, state) {
              _nameController.text = state.name;
              _passwordControllerFirst.text = state.password;
              _passwordControllerSecond.text = state.password;
              return Column(
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
                  ),
                  BasePasswordField(
                    controller: _passwordControllerFirst,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'password',
                    prefixIcon: const Icon(
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
                    title: 'Зарегистрироваться',
                    onPressed: () {
                      if(checkFields()) {
                        if(checkPassword()){
                          bloc.add(CollectingRegistrationInfoEvent(
                              name: _nameController.text,
                              password: _passwordControllerFirst.text));
                          bloc.add(StartRegisterEvent(
                            password: _passwordControllerFirst.text,
                            email: bloc.state.email,
                            name: _nameController.text,
                            phone: bloc.state.phone,
                          ));
                        }else {
                          const snackBar = SnackBar(
                            content: Text('пароли не совпадают'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        }
                      }
                      else{
                        const snackBar = SnackBar(
                          content: Text('поля не заполнены'),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
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
              );
            },
          )),
    );
  }
}