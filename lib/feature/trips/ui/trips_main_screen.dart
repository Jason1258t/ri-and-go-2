import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/trips_bloc.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';
import 'package:riandgo2/feature/Trips/ui/search_trips_screen.dart';
import 'package:riandgo2/models/models.dart';
import 'package:riandgo2/utils/animations.dart';
import 'package:riandgo2/widgets/buttons/move_button.dart';
import 'package:riandgo2/widgets/listView/search_trips_listViev.dart';
import 'package:swipe_to/swipe_to.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  bool fl = true;
  bool val = true;

  @override
  Widget build(BuildContext context) {
    final tripsBloc = BlocProvider.of<TripsBloc>(context);
    final tripsRepository = RepositoryProvider.of<TripsRepository>(context);

    Future<void> loadTrips(bool necessarily) async {
      tripsRepository.copyWithFilter(TripFilter(type: val));

      tripsBloc.add(TripsInitialLoadEvent(
          filter: tripsRepository.getFilter(), necessarily: necessarily));
    }

    void changeType({bool? type}) {
      setState(() {
        if (type == null) {
          val = !val;
        } else {
          val = type;
        }
      });
      loadTrips(false);
    }
    if (fl) {
      loadTrips(true);
      fl = false;
    }


    return RefreshIndicator(
      onRefresh: () async {
        loadTrips(true);
      },
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
                    fontWeight: FontWeight.w400))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchTrips(),
                ));
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.search),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('Assets/searchBackground.png'),
                  repeat: ImageRepeat.repeat)),
          child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: changeType,
                    child: MoveButton(
                      firstName: 'Поездки',
                      secondName: 'Запросы',
                      val: val,
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SwipeTo(
                    iconSize: 0,
                    animationDuration: const Duration(milliseconds: 50),
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: const _TripsConsumer(),
                    ),
                    onRightSwipe: () {
                      changeType(type: false);
                    },
                    onLeftSwipe: () {
                      changeType(type: true);
                    },
                  ),
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
              trips: RepositoryProvider.of<TripsRepository>(context).getTrips().reversed.toList(),
            );
          }
          if (state is TripsLoadingState) {
            return Center(child: AppAnimations.bouncingLine);
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
