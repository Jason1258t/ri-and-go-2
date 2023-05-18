import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/app/bloc/app_bloc.dart';
import 'package:riandgo2/feature/profile/bloc/main_info/profile_bloc.dart';
import 'package:riandgo2/feature/profile/bloc/trips_info/user_trips_bloc.dart';
import 'package:riandgo2/feature/profile/data/profile_repository.dart';
import 'package:riandgo2/feature/profile/ui/edit_profile_screen.dart';
import 'package:riandgo2/utils/utils.dart';
import 'package:riandgo2/widgets/lable/information_field.dart';
import 'package:riandgo2/widgets/listView/trips_listView.dart';
import 'package:riandgo2/widgets/show_elements/avatar.dart';

import '../../../widgets/buttons/default_text_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final profileRepository = RepositoryProvider.of<ProfileRepository>(context);
    final tripBloc = BlocProvider.of<UserTripsBloc>(context);
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
                          profileRepository.profileLoaded = false;
                          Navigator.of(context).pop();
                        },
                        child: const Text('Да')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Эээ куда'))
                  ],
                )
              ],
            );
          });
    }
    if (!profileRepository.isProfileLoaded()) {
      profileBloc.add(ProfileInitialLoadEvent());
    }
    return BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
      // if (state is ProfileLoadedState) {
      //   const snack = SnackBar(content: Text('профиль загружен'));
      //   ScaffoldMessenger.of(context).showSnackBar(snack);
      // }
    }, builder: (context, state) {
      if (state is ProfileLoadedState) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/searchBackground.png'),
                repeat: ImageRepeat.repeat),
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SafeArea(
                  child: Row(
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
                      const SizedBox(
                        height: 25,
                      ),
                      Avatar(
                        avatar:
                            'Assets/ProfileImage.png', // TODO заменить на серверное фото
                      ),
                      DefaultTextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EditProfile(),
                            ),
                          );
                        },
                        title: 'edit',
                        width: 100,
                        height: 45,
                        textStyle: AppTypography.font20_0xff929292,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                _Elements(
                  name: state.name,
                  phone: state.phone,
                  email: state.email,
                ),
                const Text(
                  'Созданные поездки',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      ),
                  textAlign: TextAlign.center,
                ),
                BlocConsumer<UserTripsBloc, UserTripsState>(
                  builder: (context, state) {
                    if (state is UserTripsLoadingState) {
                      return const CircularProgressIndicator();
                    }
                    if (state is UserTripsSuccessState) {
                      return ListViewTrips(trips: profileRepository.userTrips);
                    }
                    if (state is UserTripsSuccessChangeState) {
                      tripBloc.add(UserTripsInitialEvent());
                      return const CircularProgressIndicator();
                    }
                    else {
                      return const Text('ошибка загрузки');
                    }
                  },
                  listener: (context, state) {},
                )
              ],
            ),

        );
      }
      if (state is ProfileErrorState) {
        return Scaffold(
          body: Center(
            child: SizedBox(
                width: 300.0,
                height: 300.0,
                child: Image.asset(
                  'Assets/companion.png',
                )),
          ),
        );
      } else {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
    });
  }
}



class _Elements extends StatefulWidget {
  final String? name;
  final String? email;
  final String? phone;

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
              name: 'Имя пользователя',
              value: widget.name ?? 'лох',
            ),
            InfoField(
              name: 'Email',
              value: widget.email ?? 'лох',
            ),
            InfoField(
              name: 'Номер телефона',
              value: widget.phone ?? 'лох',
            ),
          ],
        )
      ],
    );
  }
}
