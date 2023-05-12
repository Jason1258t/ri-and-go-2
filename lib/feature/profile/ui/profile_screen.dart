import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/app/bloc/app_bloc.dart';
import 'package:riandgo2/feature/profile/bloc/profile_bloc.dart';
import 'package:riandgo2/feature/profile/data/profile_repository.dart';
import 'package:riandgo2/feature/profile/ui/edit_screen.dart';
import 'package:riandgo2/utils/utils.dart';
import 'package:riandgo2/widgets/lable/information_field.dart';
import 'package:riandgo2/widgets/listView/trips_listView.dart';

import '../../../widgets/buttons/default_text_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void logoutShowDialog() {
    final appBloc = BlocProvider.of<AppBloc>(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Уверены что хотите выйти?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        appBloc.add(LogoutAppEvent());
                        Navigator.of(context).pop();
                      },
                      child: Text('Да')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Эээ куда'))
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final profileRepository = RepositoryProvider.of<ProfileRepository>(context);

    if (!profileRepository.isProfileLoaded()) {
      profileBloc.add(ProfileInitialLoadEvent());
    }
    return SafeArea(
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // if (state is ProfileLoadedState) {
          //   const snack = SnackBar(content: Text('профиль загружен'));
          //   ScaffoldMessenger.of(context).showSnackBar(snack);
          // }

        },
        builder: (context, state) {
          if (state is ProfileLoadedState) {
            return Scaffold(
              body: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 15)),
                        DefaultTextButton(
                          width: 100,
                          height: 45,
                          title: 'log out',
                          textStyle: AppTypography.font20_0xff929292,
                          onPressed: logoutShowDialog,
                        ),
                        _Avatar(
                          avatar:
                              'Assets/logo.png', // TODO заменить на серверное фото
                        ),
                        DefaultTextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RepositoryProvider.value(
                                          value: profileRepository,
                                          child: BlocProvider.value(
                                            value: profileBloc,
                                            child: const EditProfile(),
                                          ),
                                        )));
                          },
                          title: 'edit',
                          width: 100,
                          height: 45,
                          textStyle: AppTypography.font20_0xff929292,
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    if (state is ProfileLoadedState)
                      _Elements(
                        name: state.name,
                        phone: state.phone,
                        email: state.email,
                      )
                    else
                      const _Elements(
                        name: 'нд',
                        phone: 'нд',
                        email: "нд",
                      ),
                    const Text(
                      'Созданные поездки',
                      style: TextStyle(
                          color: Color.fromRGBO(133, 64, 0, 1),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    ),
                    ListViewTrips(
                      trips: [],
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        },
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

class _Elements extends StatefulWidget {
  final name;
  final email;
  final phone;

  const _Elements({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  _ElementsState createState() => _ElementsState();
}

class _ElementsState extends State<_Elements> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            InfoField(
              name: 'Name',
              value: widget.name ?? 'лох',
            ),
            InfoField(
              name: 'Email',
              value: widget.email ?? 'лох',
            ),
            InfoField(
              name: 'Telephone',
              value: widget.phone ?? 'лох',
            ),
          ],
        )
      ],
    );
  }
}
