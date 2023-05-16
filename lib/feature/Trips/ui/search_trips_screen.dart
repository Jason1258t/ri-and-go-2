import 'package:flutter/material.dart';
import 'package:riandgo2/utils/colors.dart';
import 'package:riandgo2/utils/fonts.dart';
import 'package:riandgo2/widgets/buttons/save_text_button.dart';
import 'package:riandgo2/widgets/input_widgets/date_input.dart';
import 'package:riandgo2/widgets/text_fields/white_text_field.dart';

class SearchTrips extends StatefulWidget {
  SearchTrips({
    Key? key,
  }) : super(key: key);

  TextEditingController _placeFromControllerDriver = TextEditingController();
  TextEditingController _placeWhereControllerDriver = TextEditingController();

  @override
  State<SearchTrips> createState() => _SearchTripsState();
}

class _SearchTripsState extends State<SearchTrips> {
  DateTime selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEAC498),
        title: const Text('Поиск'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 329,
                  height: 330,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFF2DE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Настройка фильтра',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 24,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(height: 40,),
                        TexrField(
                          controller: widget._placeFromControllerDriver,
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          hintText: 'Откуда',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TexrField(
                          controller: widget._placeWhereControllerDriver,
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          hintText: 'Куда',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomDateInput(selectedDate: selectedDate, type: 'search filter')
                      ]),
                ),
                const SizedBox(
                  height: 50,
                ),
                SaveTextButton(
                  textStyle: AppTypography.font20grey,
                  title: 'Поиск',
                  onPressed: () {},
                  width: 329,
                  height: 50,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}