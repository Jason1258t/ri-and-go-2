import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/trips_bloc.dart';
import 'package:riandgo2/feature/add_card/bloc/add_trip_bloc.dart';
import 'package:riandgo2/models/models.dart';

class CustomDateInput extends StatefulWidget {
  DateTime selectedDate;
  final String type;

  CustomDateInput({Key? key, required this.type, required this.selectedDate})
      : super(key: key);

  @override
  State<CustomDateInput> createState() => _CustomDateInputState();
}

class _CustomDateInputState extends State<CustomDateInput> {
  @override
  Widget build(BuildContext context) {
    confirmDate(DateTime date) {
      widget.selectedDate = date;

      BlocProvider.of<AddTripBloc>(context)
          .add(AddTripSelectDateEvent(selectedDate: date));
    }

    void _selectDate() async {
      final selected = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2025),
      );
      log(selected.toString());

      if (selected != null && selected != widget.selectedDate) {
        confirmDate(selected);

        log(widget.selectedDate.toString());
      }
    }

    return BlocBuilder<AddTripBloc, AddTripState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            _selectDate();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            fixedSize: const Size(265, 47),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Когда: ${state is! AddTripSelectedDate ? widget.selectedDate.toString().split(' ')[0] : state.selectedDate.toString().split(' ')[0]}',
              style: const TextStyle(
                  color: Color(0xff747474),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
        );
      },
    );
  }
}
