import 'package:flutter/material.dart';
import 'package:riandgo2/models/models.dart';

class SearchedTripsList extends StatefulWidget {
  SearchedTripsList({Key? key, required this.trips}) : super(key: key);
  List<TripModel> trips;

  @override
  State<SearchedTripsList> createState() => _SearchedTripsListState();
}

class _SearchedTripsListState extends State<SearchedTripsList> {
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
                .map((e) => SearchedTrip(
                      trip: e,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

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
                      onPressed: () {},
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

class SearchedTrip extends StatefulWidget {
  const SearchedTrip({Key? key, required this.trip}) : super(key: key);

  final TripModel trip;


  @override
  State<SearchedTrip> createState() => _SearchedTripState();
}

class _SearchedTripState extends State<SearchedTrip> {
  bool viewType = false;

  void changeViewType () {
    setState(() {
      viewType = !viewType;
    });

  }

  @override
  Widget build(BuildContext context) {
    if (!viewType) return BaseSearchedTrip(trip: widget.trip, onPres: changeViewType,);
    else return AdvancedSearchedTrip(trip: widget.trip, onPres: changeViewType,);

  }
}



class BaseSearchedTrip extends StatelessWidget {
  const BaseSearchedTrip({Key? key, required this.trip, required this.onPres}) : super(key: key);
  final TripModel trip;
  final onPres;


  @override
  Widget build(BuildContext context) {
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
                  'Assets/logo.png',
                  width: 56,
                  height: 50,
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

class AdvancedSearchedTrip extends StatelessWidget {
  const AdvancedSearchedTrip({Key? key, required this.trip, required this.onPres}) : super(key: key);
  final TripModel trip;
  final onPres;

  @override
  Widget build(BuildContext context) {
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
        children: [
          Row(
            children: [
              Image.asset('Assets/no_image.png', width: 130, height: 90,),
              SizedBox(width: 10,),
              Image.asset('Assets/no_image.png', width: 130, height: 90,)
            ],
          ),
          SizedBox(height: 18,),
          Container(
            width: 285,
            height: 45,
            child: Row(
              children: [
                Image.asset('Assets/aboba.png'),
                Column(children: [
                  Text(trip.itemName, style: TextStyle(fontSize: 20), maxLines: 2, overflow: TextOverflow.ellipsis,),
                  Text(trip.itemDate, style: TextStyle(fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis,),
                  const SizedBox(height: 10,),
                  Text(trip.description, style: TextStyle(fontSize: 13),),
                  SizedBox(height: 43,),
                  Row(
                    children: [
                      Icon(Icons.people, size: 20,),
                      Text('4/${trip.maxPassengers}', style: TextStyle(fontSize: 14, color: Color(0xff747474)),),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Автор: ', style: TextStyle(fontSize: 15),),
                      TextButton(onPressed: () {}, child: Text('Ебланище', style: TextStyle(fontSize: 14, color: Color(0xff1EC67F)),))
                    ],
                  )
                ],)
              ],
            ),
          )
        ],
      ),
    );
  }
}
