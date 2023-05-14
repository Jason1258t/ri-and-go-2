import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/trips_bloc.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';
import 'package:riandgo2/models/TripModel.dart';
import 'package:riandgo2/models/models.dart';
import 'package:riandgo2/widgets/buttons/move_button.dart';
import 'package:riandgo2/widgets/listView/trips_listView.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  bool val = true;

  void changeType() {
    setState(() {
      val = !val;
    });
    BlocProvider.of<TripsBloc>(context).add(
        TripsInitialLoadEvent(filter: TripFilter(type: val)));
  }

  @override
  Widget build(BuildContext context) {
    final tripsBloc = BlocProvider.of<TripsBloc>(context);

    Future<void> loadTrips() async {
      tripsBloc.add(TripsInitialLoadEvent(filter: TripFilter(type: val)));
    }

    loadTrips();

    return RefreshIndicator(
      onRefresh: loadTrips,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xffFFB74B),
            toolbarHeight: 45,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text('Активные запросы',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                )
            )
          // TextButton(onPressed: () {tripAskType = !tripAskType; loadAllTrips(); setState(() {
          //
          // });}, child: Text(
          //   tripAskType? 'Созданные поездки' : 'созданные запроосы',
          //   style: TextStyle(color: Colors.black, fontSize: 25),
          // )),
        ),
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
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: changeType,
                    child: MoveButton(
                      firstName: 'Поездки',
                      secondName: 'Запросы',
                      val: val,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const _TripsConsumer(),
                ]),
          ),
        ),
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
            return SearchedTripsList(
              trips: RepositoryProvider.of<TripsRepository>(context).tripList,
            );
          }
          if (state is TripsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: SizedBox(
                    width: 300.0,
                    height: 300.0,
                    child: Image.asset(
                      'Assets/companion.png',
                    )),
              ),
            );
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
