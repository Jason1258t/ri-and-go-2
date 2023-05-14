import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/trips_bloc.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';
import 'package:riandgo2/models/TripModel.dart';
import 'package:riandgo2/widgets/listView/trips_listView.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  List<TripModel> trips = [ // TODO заменить на серверный лист
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
    final tripsBloc = BlocProvider.of<TripsBloc>(context);
    tripsBloc.add(TripsInitialLoadEvent(filter: null));
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _TripsConsumer(),
          ]
      ),
    );
  }
}

class _TripsConsumer extends StatelessWidget {
  const _TripsConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripsBloc, TripsState>(
        builder: (context, state) {
          if (state is TripsLoadedState) {
            return Container(
              child: ListViewTrips(
                trips: RepositoryProvider.of<TripsRepository>(context).tripList,
              ),
            );
          }
          if (state is TripsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('проблемки'));
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
