import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/creator_bloc/creator_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/trips_bloc.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';
import 'package:riandgo2/feature/Trips/ui/creator_info_screen.dart';
import 'package:riandgo2/feature/profile/data/profile_repository.dart';
import 'package:riandgo2/feature/trips/bloc/follow_bloc/follow_bloc.dart';
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
        onPressUrl: () {
          BlocProvider.of<CreatorBloc>(context)
              .add(CreatorInitialLoadEvent(userId: widget.trip.authorId));
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CreaterInfo(),
              ));
        },
      );
    }
  }
}

class AdvancedSearchedTrip extends StatefulWidget {
  AdvancedSearchedTrip(
      {Key? key,
      required this.trip,
      required this.onPres,
      required this.onPressUrl})
      : super(key: key);
  TripModel trip;
  final onPres;
  VoidCallback onPressUrl;

  @override
  State<AdvancedSearchedTrip> createState() => _AdvancedSearchedTripState();
}

class _AdvancedSearchedTripState extends State<AdvancedSearchedTrip> {
  @override
  Widget build(BuildContext context) {
    refreshTripData() {
      widget.trip = RepositoryProvider.of<TripsRepository>(context)
          .getTripByItemId(widget.trip.itemId)!;
    }

    final profileRepository = RepositoryProvider.of<ProfileRepository>(context);
    final followBloc = BlocProvider.of<FollowBloc>(context);
    final width = MediaQuery.of(context).size.width * 0.9;
    final imagesList = widget.trip.images ??
        RepositoryProvider.of<TripsRepository>(context).getRandomImage();
    return Container(
      width: width,
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
            children: imagesList
                .map((e) => GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  content: SizedBox(
                                      width: width, child: Image.network(e)),
                                ));
                      },
                      child: Image.network(
                        e,
                        width: 150,
                        height: 100,
                      ),
                    ))
                .toList(),
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
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.trip.itemName,
                      style: const TextStyle(fontSize: 20),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.trip.itemDate,
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
            widget.trip.description,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
            'Откуда: ${widget.trip.departurePlace}',
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            'Куда: ${widget.trip.arrivalPlace}',
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 3,
          ),
          BlocConsumer<FollowBloc, FollowState>(
            listener: (context, state) {
              if (state is FollowSuccessState) {
                refreshTripData();
              }
            },
            builder: (context, state) {
              return Column(children: [
                if (!widget.trip.tripType)
                  Row(
                    children: [
                      const Icon(
                        Icons.people,
                        size: 20,
                      ),
                      Text(
                        '${widget.trip.passengersCount}/${widget.trip.maxPassengers}',
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xff747474)),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    const Text(
                      'Автор: ',
                      style: TextStyle(fontSize: 15),
                    ),
                    widget.trip.creator
                        ? const Text('Вы',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff1EC67F)))
                        : TextButton(
                            onPressed: widget.onPressUrl,
                            child: Text(
                              widget.trip.authorName,
                              style: const TextStyle(
                                  fontSize: 14, color: Color(0xff1EC67F)),
                            ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (!widget.trip.tripType)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.trip.creator) ...[
                        const SizedBox(
                            width: 200,
                            child: Text(
                              'Вам незачем отслеживать вашу поездку',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ))
                      ] else if (widget.trip.followed) ...[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey),
                            onPressed: () {
                              followBloc.add(UnFollowInitialEvent(
                                  tripId: widget.trip.itemId,
                                  userId: profileRepository.userId));
                            },
                            child: const Text('Прекратить отслеживание'))
                      ] else if (state is! FollowFailState &&
                          widget.trip.passengersCount <
                              widget.trip.maxPassengers) ...[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber),
                            onPressed: () {
                              followBloc.add(FollowInitialEvent(
                                  tripId: widget.trip.itemId,
                                  userId: profileRepository.userId));
                            },
                            child: const Text('отслеживать'))
                      ] else if (state is! FollowFailState &&
                          widget.trip.passengersCount >=
                              widget.trip.maxPassengers) ...[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey),
                            onPressed: () {},
                            child: const Text('отслеживать'))
                      ] else ...[
                        const Text('проблемс')
                      ]
                    ],
                  ),
              ]);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: widget.onPres,
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
                  trip.tripType ? 'Assets/briefcase.png' : 'Assets/wheel.png',
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
