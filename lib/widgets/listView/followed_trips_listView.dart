import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/profile/bloc/trips_info/user_trips_bloc.dart';
import 'package:riandgo2/models/models.dart';

class ListViewFollowedTrips extends StatefulWidget {
  List<TripModel> trips;

  ListViewFollowedTrips({
    Key? key,
    required this.trips,
  }) : super(key: key);

  @override
  ListViewFollowedTripsState createState() => ListViewFollowedTripsState();
}

class ListViewFollowedTripsState extends State<ListViewFollowedTrips> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<UserTripsBloc>(context).add(UserTripsInitialEvent());
        },
        child: ListView(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: widget.trips
                  .map((e) => ProfileTrip(
                trip: e,
              ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileTrip extends StatefulWidget {
  TripModel trip;
  String itemName;
  String itemDate;
  int authorId;
  int itemId;
  bool tripType;
  String image;

  ProfileTrip({Key? key, required this.trip})
      : itemName = trip.itemName,
        itemDate = trip.itemDate,
        authorId = trip.authorId,
        itemId = trip.itemId,
        tripType = trip.tripType,
        image = trip.image,
        super(key: key);

  @override
  TripState createState() => TripState();
}

class TripState extends State<ProfileTrip> {
  @override
  Widget build(BuildContext context) {
    void confirmDelete() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                  'Уверены что хотите перестать отслеживать поездку?'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {}, //TODO нужно перестать отслеживать
                        child: const Text('Да')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Эээ куда'))
                  ],
                )
              ],
            );
          });
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.98,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 1,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'Assets/wheel.png',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        widget.itemName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.itemDate,
                    )
                  ],
                ),
                IconButton(
                    onPressed: confirmDelete,
                    icon: const Icon(Icons.dangerous_outlined))
              ])
        ],
      ),
    );
  }
}

class BaseSearchedTrip extends StatelessWidget {
  const BaseSearchedTrip({Key? key, required this.trip, required this.onPres})
      : super(key: key);
  final TripModel trip;
  final onPres;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 1,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'Assets/wheel.png',
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        trip.itemName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        '${trip.departurePlace} --> ${trip.arrivalPlace}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      trip.itemDate,
                      style: const TextStyle(
                          color: Color(0xff636363), fontSize: 14),
                    )
                  ],
                ),
                TextButton(
                    onPressed: onPres,
                    child: const Icon(
                      Icons.expand_more,
                      size: 30,
                      color: Colors.black,
                    )),
              ])
        ],
      ),
    );
  }
}