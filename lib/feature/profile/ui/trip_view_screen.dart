import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/creator_bloc/creator_bloc.dart';
import 'package:riandgo2/feature/profile/data/profile_repository.dart';
import 'package:riandgo2/feature/profile/data/trip_view_repository.dart';
import 'package:riandgo2/feature/trips/bloc/follow_bloc/follow_bloc.dart';
import 'package:riandgo2/feature/trips/data/trip_repository.dart';

import '../../../models/models.dart';
import '../../trips/ui/creator_info_screen.dart';
import '../bloc/trip_view/trip_view_bloc.dart';

class TripViewScreen extends StatelessWidget {
  const TripViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final followBloc = BlocProvider.of<FollowBloc>(context);
    final profileRepository = RepositoryProvider.of<ProfileRepository>(context);
    final TripModel trip =
        RepositoryProvider.of<TripViewRepository>(context).trip;
    final tripsRepository = RepositoryProvider.of<TripsRepository>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAC498),
        title: const Text('Поездка'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tripsRepository
                .getRandomImage()
                .map((e) => GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  content: SizedBox(
                                      width: 300, child: Image.network(e)),
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
            height: 13,
          ),
          Row(
            children: [
              const Text(
                'Откуда: ',
                style: TextStyle(fontSize: 15),
              ),
              Text(
                trip.departurePlace,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            children: [
              const Text(
                'Куда: ',
                style: TextStyle(fontSize: 15),
              ),
              Text(
                trip.arrivalPlace,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          if (!trip.tripType)
            Row(
              children: [
                const Icon(
                  Icons.people,
                  size: 20,
                ),
                Text(
                  '${trip.passengersCount}/${trip.maxPassengers}',
                  style:
                      const TextStyle(fontSize: 14, color: Color(0xff747474)),
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
                  onPressed: () {
                    BlocProvider.of<CreatorBloc>(context)
                        .add(CreatorInitialLoadEvent(userId: trip.authorId));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CreaterInfo(),
                        ));
                  },
                  child: Text(
                    trip.authorName,
                    style:
                        const TextStyle(fontSize: 14, color: Color(0xff1EC67F)),
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<FollowBloc, FollowState>(
                builder: (context, state) {
                  if (trip.followed) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey),
                        onPressed: () {
                          followBloc.add(UnFollowInitialEvent(
                              tripId: trip.itemId,
                              userId: profileRepository.userId));
                        },
                        child: const Text('Прекратить отслеживание'));
                  } else if (state is! FollowFailState) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber),
                        onPressed: () {
                          followBloc.add(FollowInitialEvent(
                              tripId: trip.itemId,
                              userId: profileRepository.userId));
                        },
                        child: const Text('отслеживать'));
                  } else {
                    return const Text('проблемс');
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
