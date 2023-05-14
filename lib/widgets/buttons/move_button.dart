import 'package:flutter/cupertino(1).dart';
import 'package:flutter/material.dart';

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

class MoveButtonState extends State<MoveButton>{
  void change() {
    setState(() {
      widget.val = !widget.val;
    });
  }

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: change,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color(0xffD9D9D9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 160,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(30),
                    color: widget.val
                        ? Colors.white
                        : Color(0xffD9D9D9)),
                child: Center(
                    child: Text(
                      widget.firstName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.val
                              ? Colors.black
                              : Colors.white),
                    )),
              ),
              Container(
                width: 160,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(30),
                    color: widget.val
                        ? Color(0xffD9D9D9)
                        : Colors.white),
                child: Center(
                    child: Text(
                      widget.secondName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.val
                              ? Colors.white
                              : Colors.black),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

