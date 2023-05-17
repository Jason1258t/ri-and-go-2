import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/profile/bloc/trips_info/user_trips_bloc.dart';
import 'package:riandgo2/models/models.dart';

class ListViewTrips extends StatefulWidget {
  List<TripModel> trips;

  ListViewTrips({
    Key? key,
    required this.trips,
  }) : super(key: key);

  @override
  ListViewTripsState createState() => ListViewTripsState();
}

class ListViewTripsState extends State<ListViewTrips> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: ()  async {BlocProvider.of<UserTripsBloc>(context).add(UserTripsInitialEvent());},
        child: ListView(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: widget.trips
                  .map((e) => ProfileTrip(
                        itemId: e.itemId,
                        itemName: e.itemName,
                        itemDate: e.itemDate,
                        authorId: e.authorId,
                        tripType: e.tripType,
                        image: e.image,
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
  String itemName;
  String itemDate;
  int authorId;
  int itemId;
  bool tripType;
  String image;

  ProfileTrip(
      {Key? key,
      required this.itemId,
      required this.itemName,
      required this.itemDate,
      required this.authorId,
      required this.tripType,
      required this.image})
      : super(key: key);

  @override
  TripState createState() => TripState();
}

class TripState extends State<ProfileTrip> {
  @override
  Widget build(BuildContext context) {
    void confirmDelete() {
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Уверены что хотите удалить?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      BlocProvider.of<UserTripsBloc>(context)
                          .add(UserTripsDeleteEvent(tripId: widget.itemId));
                      Navigator.of(context).pop();
                    },
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
      }
      );
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
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
                    widget.image,
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
                  TextButton(
                      onPressed: confirmDelete,
                      child: const Icon(
                        Icons.delete_outline,
                        size: 30,
                        color: Colors.black,
                      )),
                ])
          ],
        ),
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
                  trip.tripType? 'Assets/briefcase.png' : 'Assets/wheel.png',
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
                        '${trip.departurePlace} --> ${trip.arrivalPlace}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
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
