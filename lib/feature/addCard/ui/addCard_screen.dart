import 'package:flutter/material.dart';
import 'package:riandgo2/widgets/buttons/move_button.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  bool val = false;
  void change() {
    setState(() {
      val = !val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('Assets/searchBackground.png'),
          )),
          child: SafeArea(
            child: Column(
              children: [
                Image(image: AssetImage('Assets/logo.png')),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  child: MoveButton(
                    firstName: 'Поездку',
                    secondName: 'Запрос',
                    val: val,
                  ),
                  onTap: change,
                ),
                SizedBox(height: 10,),
                if (!val) ...[
                  AddContainer(
                    color: Colors.orangeAccent,
                  )
                ] else
                  ...[
                    AddContainer(
                      color: Colors.black,
                    )
                  ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddContainer extends StatefulWidget {
  Color color;

  AddContainer({Key? key, required this.color}) : super(key: key);

  @override
  _AddContainerState createState() => _AddContainerState();
}

class _AddContainerState extends State<AddContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
