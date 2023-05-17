import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/trips_bloc.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';
import 'package:riandgo2/feature/app/bloc/navigator_bloc.dart';
import 'package:riandgo2/models/models.dart';
import 'package:riandgo2/utils/fonts.dart';
import 'package:riandgo2/widgets/buttons/save_text_button.dart';
import 'package:riandgo2/widgets/text_fields/white_text_field.dart';

class SearchTrips extends StatefulWidget {
  SearchTrips({
    Key? key,
  }) : super(key: key);

  TextEditingController _departurePlaceContoller = TextEditingController();
  TextEditingController _arrivalPlaceControllerDriver = TextEditingController();

  @override
  State<SearchTrips> createState() => _SearchTripsState();
}

class _SearchTripsState extends State<SearchTrips> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final tripsRepository = RepositoryProvider.of<TripsRepository>(context);
    if (widget._departurePlaceContoller.text.isEmpty) {
      widget._departurePlaceContoller.text =
          tripsRepository.filter.departure ?? '';
    }
    if (widget._arrivalPlaceControllerDriver.text.isEmpty) {
      widget._arrivalPlaceControllerDriver.text =
        tripsRepository.filter.arrive ?? '';
    }

    void _selectDate() async {
      await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2025),
      ).then((value) => {
            if (value != null && value != selectedDate)
              BlocProvider.of<TripsBloc>(context)
                  .add(TripsSetFilterEvent(filter: TripFilter(date: value)))
          });

      setState(() {});
    }

    clearFilter() {
      tripsRepository.clearFilter();
      setState(() {
        widget._departurePlaceContoller.text = '';
        widget._arrivalPlaceControllerDriver.text = '';
      });
    }

    commitFilter() {
      BlocProvider.of<TripsBloc>(context).add(TripsSetFilterEvent(
          filter: TripFilter(
              departure: widget._departurePlaceContoller.text.isNotEmpty? widget._departurePlaceContoller.text : null,
              arrive: widget._arrivalPlaceControllerDriver.text.isNotEmpty? widget._arrivalPlaceControllerDriver.text : null)));
      log('----------------------------фильтр  ${tripsRepository.filter.toJson().toString()}');
      BlocProvider.of<TripsBloc>(context)
          .add(TripsInitialLoadEvent(filter: tripsRepository.filter));
      BlocProvider.of<NavigatorBloc>(context).add(NavigateSearchEvent());
      Navigator.pop(context);
    }

    log(tripsRepository.filter.date.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAC498),
        title: const Text('Поиск'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Column(
              children: [
                BlocBuilder<TripsBloc, TripsState>(
                  builder: (context, state) {
                    return Container(
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
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TexrField(
                              controller: widget._departurePlaceContoller,
                              keyboardType: TextInputType.name,
                              maxLines: 1,
                              hintText: 'Откуда',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TexrField(
                              controller: widget._arrivalPlaceControllerDriver,
                              keyboardType: TextInputType.name,
                              maxLines: 1,
                              hintText: 'Куда',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextButton(
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
                                  'Когда: ${tripsRepository.filter.date == null ? '' : tripsRepository.filter.date.toString().split(' ')[0]}',
                                  style: const TextStyle(
                                      color: Color(0xff747474),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          ]),
                    );
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                SaveTextButton(
                  textStyle: AppTypography.font20grey,
                  title: 'Поиск',
                  onPressed: commitFilter,
                  width: 329,
                  height: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: clearFilter,
                    child: const Text('очистить'))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
