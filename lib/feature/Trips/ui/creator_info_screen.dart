import 'package:flutter/material.dart';
import 'package:riandgo2/utils/fonts.dart';
import 'package:riandgo2/widgets/buttons/save_text_button.dart';
import 'package:riandgo2/widgets/lable/information_field.dart';

class CreaterInfo extends StatefulWidget {
  const CreaterInfo({Key? key}) : super(key: key);

  @override
  _CreaterInfoState createState() => _CreaterInfoState();
}

class _CreaterInfoState extends State<CreaterInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _Avatar(avatar: 'Assets/logo.png',),//TODO догружеться из базы
                const SizedBox(height: 20,),
                const _Elements(name: null, email: null, phone: null,), // TODO ввод с репозитория
                SaveTextButton(
                  textStyle: AppTypography.font20grey,
                  title: 'Написать',
                  onPressed: () {}, //TODO Подгружать ссылку на чела
                  width: 329,
                  height: 50,
                ),
              ]),
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