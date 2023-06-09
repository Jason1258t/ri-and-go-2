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
          tripsRepository.getFilter().departure ?? '';
    }
    if (widget._arrivalPlaceControllerDriver.text.isEmpty) {
      widget._arrivalPlaceControllerDriver.text =
          tripsRepository.getFilter().arrive ?? '';
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
      final dp = widget._departurePlaceContoller.text.trim();
      final ap = widget._arrivalPlaceControllerDriver.text.trim();

      BlocProvider.of<TripsBloc>(context).add(TripsSetFilterEvent(
          filter: TripFilter(
              departure: dp.isNotEmpty ? dp : null,
              arrive: ap.isNotEmpty ? ap : null)));
      BlocProvider.of<TripsBloc>(context)
          .add(TripsInitialLoadEvent(filter: tripsRepository.getFilter()));
      BlocProvider.of<NavigatorBloc>(context).add(NavigateSearchEvent());
      Navigator.pop(context);
    }

    log(tripsRepository.getFilter().date.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAC498),
        title: const Text('Поиск'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/searchBackground.png'),
                repeat: ImageRepeat.repeat)),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
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
                                controller:
                                    widget._arrivalPlaceControllerDriver,
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
                                    'Когда: ${tripsRepository.getFilter().date == null ? '' : tripsRepository.getFilter().date.toString().split(' ')[0]}',
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
                      onPressed: clearFilter, child: const Text('очистить'))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
