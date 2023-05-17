import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/creator_bloc/creator_bloc.dart';
import 'package:riandgo2/utils/fonts.dart';
import 'package:riandgo2/widgets/buttons/save_text_button.dart';
import 'package:riandgo2/widgets/lable/information_field.dart';
import 'package:url_launcher/url_launcher.dart';

class CreaterInfo extends StatefulWidget {
  const CreaterInfo({Key? key}) : super(key: key);

  @override
  _CreaterInfoState createState() => _CreaterInfoState();
}

class _CreaterInfoState extends State<CreaterInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEAC498),
          title: const Text('Автор поездки'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocConsumer<CreatorBloc, CreatorState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is CreatorSuccessState) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      _Avatar(
                        avatar: 'Assets/ProfileImage.png',
                      ),
                      //TODO догружеться из базы
                      const SizedBox(
                        height: 20,
                      ),
                      _Elements(
                        name: state.name,
                        email: state.email,
                        phone: state.phone,
                      ),
                      // TODO ввод с репозитория
                      const SizedBox(
                        height: 50,
                      ),
                      if (state.contactUrl != null)
                        SaveTextButton(
                          textStyle: AppTypography.font20grey,
                          title: 'Написать',
                          onPressed: () async {
                            if (state.contactUrl != null &&
                                state.contactUrl!.isNotEmpty) {
                              //final Uri _url = Uri.parse(state.contactUrl!);
                              await launch(state.contactUrl!);
                            }
                          },
                          //TODO Подгружать ссылку на чела
                          width: 329,
                          height: 50,
                        )
                      else
                        (const SizedBox(
                          width: 250,
                          child: Text(
                            'Этот пользователь не указал соцсети для связи',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    ]);
              }
              if (state is CreatorLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset('Assets/companion.jpg'),
                  ),
                );
              }
            },
          ),
        ));
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
      backgroundColor: const Color.fromARGB(20, 51, 51, 51),
      radius: 71,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 70,
        child: CircleAvatar(
          backgroundImage:
          AssetImage(widget.avatar ?? 'Assets/ProfileImage.png'),
          backgroundColor: Colors.white,
          radius: 65,
        ),
      ),
    );
  }
}
