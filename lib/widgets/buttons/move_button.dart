import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/trips_bloc.dart';
import 'package:riandgo2/models/models.dart';

class MoveButton extends StatefulWidget {
  String firstName;
  String secondName;
  bool val;

  MoveButton({
    Key? key,
    required this.firstName,
    required this.secondName,
    required this.val,
  }) : super(key: key);

  @override
  MoveButtonState createState() => MoveButtonState();
}

class MoveButtonState extends State<MoveButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xffD9D9D9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ContainerBox(
              val: widget.val,
              title: widget.firstName,
            ),
            ContainerBox(
              val: !widget.val,
              title: widget.secondName,
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerBox extends StatefulWidget {
  bool val;
  String title;

  ContainerBox({
    Key? key,
    required this.val,
    required this.title,
  }) : super(key: key);

  @override
  _ContainerBoxState createState() => _ContainerBoxState();
}

class _ContainerBoxState extends State<ContainerBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:
              widget.val ? const Color(0xffD9D9D9) : const Color(0xffFFB74B)),
      child: Center(
          child: Text(
        widget.title,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: widget.val ? Colors.black : Colors.white),
      )),
    );
  }
}