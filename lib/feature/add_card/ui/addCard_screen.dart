import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/add_card/bloc/add_trip_bloc.dart';
import 'package:riandgo2/feature/app/bloc/navigator_bloc.dart';
import 'package:riandgo2/feature/profile/bloc/trips_info/user_trips_bloc.dart';
import 'package:riandgo2/models/models.dart';
import 'package:riandgo2/utils/fonts.dart';
import 'package:riandgo2/widgets/buttons/move_button.dart';
import 'package:riandgo2/widgets/buttons/save_text_button.dart';
import 'package:riandgo2/widgets/input_widgets/date_input.dart';
import 'package:riandgo2/widgets/text_fields/white_text_field.dart';

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
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/searchBackground.png'),
                repeat: ImageRepeat.repeat),
          ),
          child: SafeArea(
            child: Center(
              child: BlocListener<AddTripBloc, AddTripState>(
                listener: (context, state) {
                  if (state is AddTripSuccessState) {
                    const snackBar = SnackBar(content: Text('Успешно'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    BlocProvider.of<NavigatorBloc>(context)
                        .add(NavigateProfileEvent());
                    BlocProvider.of<UserTripsBloc>(context).add(UserTripsInitialEvent());
                  }
                  if (state is AddTripFailState) {
                    const snackBar = SnackBar(content: Text('все пошло по пизде'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
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
                        width: 300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (!val) ...[
                      DriverCard(),
                    ] else ...[
                      PassengerCard(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DriverCard extends StatefulWidget {
  TextEditingController _nameControllerPassenger = TextEditingController();
  TextEditingController _departurePlaceControllerPassenger = TextEditingController();
  TextEditingController _arrivalPlaceControllerPassenger =
      TextEditingController();
  TextEditingController _descriptionControllerPassenger =
      TextEditingController();
  TextEditingController _maxPassengersControllerDriver =
      TextEditingController();

  DriverCard({Key? key, required}) : super(key: key);

  @override
  _DriverCardState createState() => _DriverCardState();
}

class _DriverCardState extends State<DriverCard> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTripBloc, AddTripState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        final bloc = BlocProvider.of<AddTripBloc>(context);

        void createTrip() {
          if (state is AddTripSelectedDate) {
            final trip = AddTripModel(
                name: widget._nameControllerPassenger.text.trim(),
                description: widget._descriptionControllerPassenger.text.trim(),
                departureTime: state.selectedDate,
                departurePlace: widget._departurePlaceControllerPassenger.text.trim(),
                arrivalPlace: widget._arrivalPlaceControllerPassenger.text.trim(),
                tripType: false,
                maxPassengers: widget._maxPassengersControllerDriver.text.trim());
            bloc.add(AddTripInitialEvent(trip: trip));
          }
          else {
            const snackBar = SnackBar(content: Text('не введена дата'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

        }

        return Column(
          children: [
            Container(
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
                      controller: widget._departurePlaceControllerPassenger,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      hintText: 'Откуда',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TexrField(
                      controller: widget._arrivalPlaceControllerPassenger,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      hintText: 'Куда',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomDateInput(selectedDate: selectedDate, type: 'context', fixedWidth: 267,),
                    const SizedBox(
                      height: 10,
                    ),
                    TexrField(
                      controller: widget._maxPassengersControllerDriver,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      hintText: 'Кол-во человек',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TexrField(
                      controller: widget._descriptionControllerPassenger,
                      keyboardType: TextInputType.name,
                      maxLines: 3,
                      hintText: 'Описание',
                      height: 120,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SaveTextButton(
              textStyle: AppTypography.font20grey,
              title: 'Создать',
              onPressed: createTrip,
              width: 300,
              height: 50,
            ),
          ],
        );
      },
    );
  }
}

class PassengerCard extends StatefulWidget {
  PassengerCard({Key? key}) : super(key: key);

  TextEditingController _nameControllerDriver = TextEditingController();
  TextEditingController _departurePlaceControllerDriver = TextEditingController();
  TextEditingController _arrivalPlaceControllerDriver = TextEditingController();
  TextEditingController _descriptionControllerDriver = TextEditingController();

  @override
  _PassengerCardState createState() => _PassengerCardState();
}

class _PassengerCardState extends State<PassengerCard> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTripBloc, AddTripState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<AddTripBloc>(context);
        void createTrip () {
          if (state is AddTripSelectedDate) {
            log(state.selectedDate.toString());
            final trip = AddTripModel(
                name: widget._nameControllerDriver.text.trim(),
                description: widget._descriptionControllerDriver.text.trim(),
                departureTime: state.selectedDate,
                departurePlace: widget._departurePlaceControllerDriver.text.trim(),
                arrivalPlace: widget._arrivalPlaceControllerDriver.text.trim(),
                tripType: true,
                maxPassengers: '99');
            bloc.add(AddTripInitialEvent(trip: trip));
          }
          else {
            const snackBar = SnackBar(content: Text('не введена дата'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }


        return Column(
          children: [
            Container(
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
                      controller: widget._departurePlaceControllerDriver,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      hintText: 'Откуда',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TexrField(
                      controller: widget._arrivalPlaceControllerDriver,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      hintText: 'Куда',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomDateInput(selectedDate: selectedDate, type: 'context', fixedWidth: 267),
                    const SizedBox(
                      height: 10,
                    ),
                    TexrField(
                      controller: widget._descriptionControllerDriver,
                      keyboardType: TextInputType.name,
                      maxLines: 3,
                      hintText: 'Описание',
                      height: 125,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SaveTextButton(
              textStyle: AppTypography.font20grey,
              title: 'Создать',
              onPressed: createTrip,
              width: 300,
              height: 50,
            ),
          ],
        );
      },
    );
  }
}
