import 'package:flutter/material.dart';
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
      child: ListView(
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: widget.trips
                .map((e) => Trip(
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
    );
  }
}

class Trip extends StatefulWidget {
  String itemName;
  String itemDate;
  int authorId;
  int itemId;
  bool tripType;
  String image;

  Trip(
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

class TripState extends State<Trip> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 15, top: 0),
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.6),
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
                    width: 22,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Flexible(
                            child: Text(widget.itemName),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.itemDate,
                      )
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.delete_outline,
                        size: 40,
                        color: Colors.black,
                      )),
                ])
          ],
        ),
      ),
    );
  }
}
