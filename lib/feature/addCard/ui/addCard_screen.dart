import 'package:flutter/material.dart';
import 'package:riandgo2/feature/profile/bloc/main_info/profile_bloc.dart';
import 'package:riandgo2/utils/colors.dart';
import 'package:riandgo2/utils/fonts.dart';
import 'package:riandgo2/widgets/buttons/move_button.dart';
import 'package:riandgo2/widgets/buttons/save_text_button.dart';
import 'package:riandgo2/widgets/text_fields/noneUnderLine_text_field.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController _nameControllerPassenger = TextEditingController();
  TextEditingController _thenControllerPassager = TextEditingController();
  TextEditingController _placeFromControllerPassenger = TextEditingController();
  TextEditingController _placeWhereControllerPassenger =
      TextEditingController();
  TextEditingController _DescriptionControllerPassenger =
      TextEditingController();

  bool val = false;

  void change() {
    setState(() {
      val = !val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'Assets/logo.png',
                  height: 87,
                  width: 80,
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: change,
                  child: MoveButton(
                    firstName: 'Поездку',
                    secondName: 'Запрос',
                    val: val,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (!val) ...[
                  DriverCard(),
                  SizedBox(
                    height: 10,
                  ),
                  SaveTextButton(
                    textStyle: AppTypography.font20grey,
                    title: 'Создать',
                    onPressed: () {},
                    width: 350,
                    height: 50,
                  ),
                ] else ...[
                  PassengerCard(),
                  SizedBox(
                    height: 10,
                  ),
                  SaveTextButton(
                    textStyle: AppTypography.font20grey,
                    title: 'Создать',
                    onPressed: () {},
                    width: 350,
                    height: 50,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DriverCard extends StatefulWidget {
  TextEditingController _nameControllerPassenger = TextEditingController();
  TextEditingController _placeFromControllerPassenger = TextEditingController();
  TextEditingController _placeWhereControllerPassenger =
      TextEditingController();
  TextEditingController _thenControllerPassager = TextEditingController();
  TextEditingController _DescriptionControllerPassenger =
      TextEditingController();
  TextEditingController _CountPassegerControllerDriver =
      TextEditingController();

  DriverCard({Key? key, required}) : super(key: key);

  @override
  _DriverCardState createState() => _DriverCardState();
}

class _DriverCardState extends State<DriverCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 440,
      decoration: BoxDecoration(
        color: const Color(0xffFFF2DE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TexrField(
              controller: widget._nameControllerPassenger,
              keyboardType: TextInputType.name,
              maxLines: 1,
              hintText: 'Название',
            ),
            const SizedBox(
              height: 10,
            ),
            TexrField(
              controller: widget._placeFromControllerPassenger,
              keyboardType: TextInputType.name,
              maxLines: 1,
              hintText: 'Откуда',
            ),
            const SizedBox(
              height: 10,
            ),
            TexrField(
              controller: widget._placeWhereControllerPassenger,
              keyboardType: TextInputType.name,
              maxLines: 1,
              hintText: 'Куда',
            ),
            const SizedBox(
              height: 10,
            ),
            TexrField(
              controller: widget._thenControllerPassager,
              keyboardType: TextInputType.name,
              maxLines: 1,
              hintText: 'Когда',
            ),
            const SizedBox(
              height: 10,
            ),
            TexrField(
              controller: widget._CountPassegerControllerDriver,
              keyboardType: TextInputType.name,
              maxLines: 1,
              hintText: 'Кол-во человек',
            ),
            const SizedBox(
              height: 10,
            ),
            TexrField(
              controller: widget._DescriptionControllerPassenger,
              keyboardType: TextInputType.name,
              maxLines: 3,
              hintText: 'Описание',
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}

class PassengerCard extends StatefulWidget {
  PassengerCard({Key? key}) : super(key: key);

  TextEditingController _nameControllerDriver = TextEditingController();
  TextEditingController _thenControllerDriver = TextEditingController();
  TextEditingController _placeFromControllerDriver = TextEditingController();
  TextEditingController _placeWhereControllerDriver = TextEditingController();
  TextEditingController _DescriptionControllerDriver = TextEditingController();

  @override
  _PassengerCardState createState() => _PassengerCardState();
}

class _PassengerCardState extends State<PassengerCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 385,
      decoration: BoxDecoration(
        color: const Color(0xffFFF2DE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TexrField(
              controller: widget._nameControllerDriver,
              keyboardType: TextInputType.name,
              maxLines: 1,
              hintText: 'Название',
            ),
            const SizedBox(
              height: 10,
            ),
            TexrField(
              controller: widget._placeFromControllerDriver,
              keyboardType: TextInputType.name,
              maxLines: 1,
              hintText: 'Откуда',
            ),
            const SizedBox(
              height: 10,
            ),
            TexrField(
              controller: widget._placeWhereControllerDriver,
              keyboardType: TextInputType.name,
              maxLines: 1,
              hintText: 'Куда',
            ),
            const SizedBox(
              height: 10,
            ),
            TexrField(
              controller: widget._thenControllerDriver,
              keyboardType: TextInputType.name,
              maxLines: 1,
              hintText: 'Когда',
            ),
            const SizedBox(
              height: 10,
            ),
            TexrField(
              controller: widget._DescriptionControllerDriver,
              keyboardType: TextInputType.name,
              maxLines: 3,
              hintText: 'Описание',
              height: 125,
            ),
          ],
        ),
      ),
    );
  }
}

class TexrField extends StatefulWidget {
  TexrField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.maxLines,
    required this.hintText,
    this.height = 50,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final String hintText;
  double? height;

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<TexrField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: widget.height,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: NoneUnderLineTextField(
        height: 50,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        hintText: widget.hintText,
        maxLines: widget.maxLines,
      ),
    );
  }
}
