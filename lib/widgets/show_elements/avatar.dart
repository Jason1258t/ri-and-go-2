import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  String? avatar;

  Avatar({
    Key? key,
    required this.avatar,
  }) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
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