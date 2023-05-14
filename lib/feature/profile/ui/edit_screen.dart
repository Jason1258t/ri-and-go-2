import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/profile/bloc/main_info/profile_bloc.dart';
import 'package:riandgo2/feature/profile/data/profile_repository.dart';
import 'package:riandgo2/utils/utils.dart';
import 'package:riandgo2/widgets/buttons/save_text_button.dart';

import 'package:riandgo2/widgets/text_fields/base_text_form_field.dart';

import '../../../models/models.dart';
import '../../../widgets/buttons/default_text_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final profileRepository = RepositoryProvider.of<ProfileRepository>(context);
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileEditSuccessState) {
              const snack = SnackBar(content: Text('Изменения внесены'));
              ScaffoldMessenger.of(context).showSnackBar(snack);
              Navigator.pop(context);
            }
            if (state is ProfileEditFailState) {
              const snack = SnackBar(content: Text('ошибка, попробуйте позже'));
              ScaffoldMessenger.of(context).showSnackBar(snack);
            }
          },
          builder: (context, state) {
            if (profileRepository.isProfileLoaded() &&
                _nameController.text.isEmpty) {
              _nameController.text = profileRepository.userInfo.name;
              _emailController.text = profileRepository.userInfo.email;
              _telephoneController.text =
                  profileRepository.userInfo.phoneNumber;
              _linkController.text = profileRepository.userInfo.contactUrl;

              return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('Assets/searchBackground.png'),
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 15)),
                        const SizedBox(width: 100),
                        _Avatar(
                          avatar:
                              'Assets/logo.png', // TODO заменить на серверное фото
                        ),
                        DefaultTextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          // TODO сделать нормальную переодресацию
                          title: 'назад',
                          width: 100,
                          height: 45,
                          textStyle: AppTypography.font20_0xff929292,
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    BaseTextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      hintText: 'имя пользователя',
                      suffixIcon: const Icon(Icons.edit_outlined),
                    ),
                    BaseTextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.name,
                      hintText: 'email',
                      suffixIcon: const Icon(Icons.edit_outlined),
                    ),
                    BaseTextFormField(
                      controller: _telephoneController,
                      keyboardType: TextInputType.name,
                      hintText: 'телефон',
                      suffixIcon: const Icon(Icons.edit_outlined),
                    ),
                    BaseTextFormField(
                      controller: _linkController,
                      keyboardType: TextInputType.name,
                      hintText: 'ссылка на соцсети',
                      suffixIcon: const Icon(Icons.edit_outlined),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SaveTextButton(
                      textStyle: AppTypography.font20grey,
                      title: 'Сохранить',
                      onPressed: () {
                        profileBloc.add(ProfileEditInitialEvent(
                            name: _nameController.text,
                            email: _emailController.text,
                            phoneNumber: _telephoneController.text,
                            contactUrl: _linkController.text));
                      },
                      //TODO Сдлелать сохраниение номрмальное
                      width: 350,
                      height: 45,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class _Avatar extends StatefulWidget {
  String? avatar;

  _Avatar({
    Key? key,
    required this.avatar,
  }) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<_Avatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.amberAccent,
      radius: 90,
      child: CircleAvatar(
        backgroundImage: AssetImage(widget.avatar ?? 'Assets/logo.png'),
        backgroundColor: Colors.white,
        radius: 80,
      ),
    );
  }
}
