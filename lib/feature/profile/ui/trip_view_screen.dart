import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/creator_bloc/creator_bloc.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';
import 'package:riandgo2/feature/profile/data/profile_repository.dart';
import 'package:riandgo2/feature/profile/data/trip_view_repository.dart';
import 'package:riandgo2/feature/trips/bloc/follow_bloc/follow_bloc.dart';

import '../../../models/models.dart';
import '../../trips/ui/creator_info_screen.dart';

class TripViewScreen extends StatelessWidget {
  const TripViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TripModel trip =
        RepositoryProvider.of<TripViewRepository>(context).trip;
    Future<void> _showAlertDialog() async {
      final followBloc = BlocProvider.of<FollowBloc>(context);
      final profileRepository =
          RepositoryProvider.of<ProfileRepository>(context);

      return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title:
                  const Text('Вы уверены что хотите перестать отслежживать?'),
              actions: [
                TextButton(
                  child: const Text("Да"),
                  onPressed: () {
                    followBloc.add(UnFollowProfileEvent(
                        itemId: trip.itemId));
                    Navigator.pop(context);
                  }, // TODo напихнуть сюда отписку от поездки
                ),
                TextButton(
                  child: const Text("Нет"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAC498),
        title: const Text('Поездка'),
        centerTitle: true,
      ),
      body: BlocListener<FollowBloc, FollowState>(
        listener: (context, state) {
          if (state is FollowSuccessState) Navigator.of(context).pop();
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/searchBackground.png'),
                repeat: ImageRepeat.repeat),
          ),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: trip.images!
                          .map((e) => GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            content: SizedBox(
                                                width: 100,
                                                child: Image.network(e)),
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
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  Container(
                    width: 285,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('Assets/aboba.png'),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              trip.itemName,
                              style: const TextStyle(fontSize: 20),
                              maxLines: 2,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Дата: ${trip.itemDate}',
                      style: const TextStyle(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Описание: ${trip.description}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Откуда: ${trip.departurePlace}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Куда: ${trip.arrivalPlace}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.people,
                          size: 20,
                        ),
                        Text(
                          '${trip.passengersCount}/${trip.maxPassengers}',
                          style: const TextStyle(
                              fontSize: 16, color: Color(0xff747474)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Автор: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {
                              BlocProvider.of<CreatorBloc>(context).add(
                                  CreatorInitialLoadEvent(
                                      userId: trip.authorId));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CreaterInfo(),
                                  ));
                            },
                            child: Text(
                              trip.authorName,
                              style: const TextStyle(
                                  fontSize: 18, color: Color(0xff1EC67F)),
                            ))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey),
                          onPressed: () async {
                            _showAlertDialog();
                          },
                          child: const Text('Прекратить отслеживание')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
