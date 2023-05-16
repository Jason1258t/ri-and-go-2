import 'package:flutter/material.dart';
import 'package:riandgo2/feature/Trips/ui/creator_info_screen.dart';
import 'package:riandgo2/models/TripModel.dart';
import 'package:riandgo2/widgets/listView/trips_listView.dart';

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

class SearchedTrip extends StatefulWidget {
  const SearchedTrip({Key? key, required this.trip}) : super(key: key);

  final TripModel trip;

  @override
  State<SearchedTrip> createState() => _SearchedTripState();
}

class _SearchedTripState extends State<SearchedTrip> {
  bool viewType = false;

  void changeViewType() {
    setState(() {
      viewType = !viewType;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!viewType) {
      return BaseSearchedTrip(
        trip: widget.trip,
        onPres: changeViewType,
      );
    } else {
      return AdvancedSearchedTrip(
        trip: widget.trip,
        onPres: changeViewType,
        onPressUrl: () { Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreaterInfo(),
            ));},
      );
    }
  }
}

class AdvancedSearchedTrip extends StatelessWidget {
  AdvancedSearchedTrip(
      {Key? key, required this.trip, required this.onPres, required this.onPressUrl})
      : super(key: key);
  final TripModel trip;
  final onPres;
  VoidCallback onPressUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 1,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'Assets/no_image.png',
                width: 130,
                height: 90,
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                'Assets/no_image.png',
                width: 130,
                height: 90,
              )
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Container(
            width: 285,
            height: 45,
            child: Row(
              children: [
                Image.asset('Assets/aboba.png'),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      trip.itemName,
                      style: const TextStyle(fontSize: 20),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      trip.itemDate,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            trip.description,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 23,
          ),
          Row(children: [
            const Text('Откуда: ', style: TextStyle(fontSize: 15),),
            Text(trip.departurePlace, style: TextStyle(fontSize: 15),)
          ],),
          const SizedBox(height: 7,),
          Row(children: [
            const Text('Куда: ', style: TextStyle(fontSize: 15),),
            Text(trip.arrivalPlace, style: TextStyle(fontSize: 15),)
          ],),
          const SizedBox(height: 15,),
          if (!trip.tripType) Row(
            children: [
              const Icon(
                Icons.people,
                size: 20,
              ),
              Text(
                '4/${trip.maxPassengers}',
                style: const TextStyle(fontSize: 14, color: Color(0xff747474)),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Автор: ',
                style: TextStyle(fontSize: 15),
              ),
              TextButton(
                  onPressed: onPressUrl,
                  child: const Text(
                    'Ебланище',
                    style: TextStyle(fontSize: 14, color: Color(0xff1EC67F)),
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: onPres,
                  child: const Icon(
                    Icons.expand_less,
                    size: 40,
                    color: Colors.black,
                  )),
            ],
          )
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