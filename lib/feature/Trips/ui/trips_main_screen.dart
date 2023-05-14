import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/trips_bloc.dart';
import 'package:riandgo2/models/TripModel.dart';
import 'package:riandgo2/widgets/buttons/move_button.dart';
import 'package:riandgo2/widgets/listView/trips_listView.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  bool val = true;
  void change() {
    setState(() {
      val != val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tripsBloc = BlocProvider.of<TripsBloc>(context);
    tripsBloc.add(TripsInitialLoadEvent(filter: null));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/searchBackground.png'),
            )),
        child: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: MoveButton(
                    firstName: 'Поездки',
                    secondName: 'Запросы',
                    val: val,
                  ),
                  onTap: change,
                ),
                _TripsConsumer(),
              ]),
        ),
      ),
    );
  }
}

class _TripsConsumer extends StatelessWidget {
  _TripsConsumer({Key? key}) : super(key: key);

  List<TripModel> trips = [
    // TODO заменить на серверный лист
    TripModel(
        itemId: 1,
        itemName: 'поездка',
        itemDate: 'дата',
        authorId: 12,
        tripType: true,
        image: 'Assets/logo.png'),
    TripModel(
        itemId: 1,
        itemName: 'asdfsadf',
        itemDate: 'asfdasdf',
        authorId: 12,
        tripType: false,
        image: 'Assets/logo.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripsBloc, TripsState>(
        builder: (context, state) {
          if (1 == 1) {
            return ListViewTrips(
              trips: trips,
            );
          } else {
            return Text('asdfsad');
          }
        },
        listener: (context, state) {});
  }
}

class SwitchButton extends StatelessWidget {
  final bool type;
  final String text;
  final onPressed;

  const SwitchButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      child: Text(
        text,
      ),
    );
  }
}
