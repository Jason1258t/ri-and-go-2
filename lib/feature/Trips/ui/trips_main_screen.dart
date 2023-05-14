import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/bloc/trips_bloc.dart';
import 'package:riandgo2/feature/Trips/data/trip_repository.dart';
import 'package:riandgo2/widgets/listView/trips_listView.dart';

// class TripScreen extends StatefulWidget {
//   const TripScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TripScreen> createState() => _TripScreenState();
// }
//
// class _TripScreenState extends State<TripScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final tripsBloc = BlocProvider.of<TripsBloc>(context);
//     tripsBloc.add(TripsInitialLoadEvent(filter: null));
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: const [
//             SizedBox(
//               height: 20,
//             ),
//             //_TripsType(),
//             Text('Абоба'),
//             //_TripsConsumer(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class TripScreen extends StatelessWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _TripsType(),
      ],
    );
  }
}



class _TripsType extends StatefulWidget {
  const _TripsType({Key? key}) : super(key: key);

  @override
  State<_TripsType> createState() => _TripsTypeState();
}

class _TripsTypeState extends State<_TripsType> {
  bool selectedType = false;

  void changeType() {
    setState(() {
      selectedType = !selectedType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 20,
        width: 200,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xffD9D9D9)),
        child: Row(
          children: [
            SwitchButton(
                onPressed: changeType, text: 'поездки', type: selectedType),
            SwitchButton(
                onPressed: changeType, text: 'запросы', type: !selectedType)
          ],
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
            return Container(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListViewTrips(
                trips: RepositoryProvider.of<TripsRepository>(context).tripList,
              ),
            );
          }
          if (state is TripsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('проблемки'));
          }
        },
        listener: (context, state) {});
  }
}

class SwitchButton extends StatelessWidget {
  final bool type;
  final String text;
  final onPressed;

  const SwitchButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.type})
      : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   if (type) {
  //     return Container(
  //       decoration: const BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.all(Radius.circular(10))),
  //       child: Text(text),
  //     );
  //   } else {
  //     return Container(
  //       decoration: const BoxDecoration(
  //           color: Color(0xffD9D9D9),
  //           borderRadius: BorderRadius.all(Radius.circular(10))),
  //       child: Text(text),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      child: Text(
        text,
      ),
    );
  }
}
