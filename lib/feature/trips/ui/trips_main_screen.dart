import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/trips_bloc.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';
import 'package:riandgo2/feature/Trips/ui/search_trips_screen.dart';
import 'package:riandgo2/models/models.dart';
import 'package:riandgo2/widgets/buttons/move_button.dart';
import 'package:riandgo2/widgets/listView/search_trips_listViev.dart';

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
    final tripsRepository = RepositoryProvider.of<TripsRepository>(context);

    Future<void> loadTrips() async {
      tripsRepository.copyWithFilter(TripFilter(type: val));
      tripsBloc.add(TripsInitialLoadEvent(filter: tripsRepository.filter));
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
        ),

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
                      width: MediaQuery.of(context).size.width * 0.85,
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
