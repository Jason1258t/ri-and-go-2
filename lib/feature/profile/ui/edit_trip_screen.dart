import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/app/bloc/app_bloc.dart';
import 'package:riandgo2/feature/profile/bloc/trips_info/user_trips_bloc.dart';
import 'package:riandgo2/models/TripEditModel.dart';
import 'package:riandgo2/models/models.dart';
import 'package:riandgo2/utils/fonts.dart';
import 'package:riandgo2/widgets/input_widgets/date_input.dart';

import '../../trips/data/trip_repository.dart';

class EditTrip extends StatefulWidget {
  final TripModel tripModel;

  EditTrip({Key? key, required this.tripModel}) : super(key: key);

  @override
  State<EditTrip> createState() => _EditTripState();
}

class _EditTripState extends State<EditTrip> {
  TextEditingController _nameControllerDriver =
      TextEditingController(); // TODo поставить деволтные значения с бд все что ниже
  TextEditingController _departurePlaceControllerDriver =
      TextEditingController();
  TextEditingController _arrivalPlaceControllerDriver = TextEditingController();
  TextEditingController _descriptionControllerDriver = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _displayTextInputDialog(BuildContext context,
      TextEditingController controller, String titleAlertDialog, String editType) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Изменить $titleAlertDialog'),
            content: TextField(
              onChanged: (value) {},
              controller: controller,
              decoration: const InputDecoration(
                //hintText: "", // TODo подгрущка с бд
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Сохранить'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    setState(() {});
                  });
                  BlocProvider.of<UserTripsBloc>(context).add(UserTripsCommitChange(tripChanges: {editType: controller.text, 'id': widget.tripModel.itemId}.tripEditFromJason()));
                },
              )
            ],
          );
        });
  }

  void _initialControllersValues() {
    if (_nameControllerDriver.text.isEmpty) {
      _nameControllerDriver.text = widget.tripModel.itemName;
    }
    if (_departurePlaceControllerDriver.text.isEmpty) {
      _departurePlaceControllerDriver.text = widget.tripModel.departurePlace;
    }
    if (_arrivalPlaceControllerDriver.text.isEmpty) {
      _arrivalPlaceControllerDriver.text = widget.tripModel.arrivalPlace;
    }
    if (_descriptionControllerDriver.text.isEmpty) {
      _descriptionControllerDriver.text = widget.tripModel.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    _initialControllersValues();
    List<String> getRandomImage() {
      int n = Random().nextInt(2);
      if (n == 1) {
        return ['https://sportishka.com/uploads/posts/2022-03/1647538575_4-sportishka-com-p-poezdka-s-semei-na-mashine-turizm-krasivo-4.jpg', 'https://aybaz.ru/wp-content/uploads/4/c/c/4ccfe1a1d3366c78552959f0c74d2622.jpeg'];
      } else {
        return ['https://aybaz.ru/wp-content/uploads/4/c/c/4ccfe1a1d3366c78552959f0c74d2622.jpeg'];
      }
    }
    
    
    final images = getRandomImage().map((e) => Image.network(e, width: 130, height: 90,)).toList();
    return BlocConsumer<UserTripsBloc, UserTripsState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактирование'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('Assets/searchBackground.png'),
              repeat: ImageRepeat.repeat),
        ),
        child: Center(
          child: Container(
            height: 597,
            width: 324,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white10, width: 4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                images
                ,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(Icons.edit_note),
                      onPressed: () {
                        _displayTextInputDialog(
                            context, _nameControllerDriver, 'название поездки', 'name');
                      },
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 250,
                    child: Text(
                      'Поездка: ${_nameControllerDriver.text}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.font16,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      icon: const Icon(Icons.edit_note),
                      onPressed: () {},
                    ),
                  ),
                  CustomDateInput(
                    selectedDate: selectedDate,
                    type: 'context',
                    fixedWidth: 150,
                    callback: (DateTime date) {
                      BlocProvider.of<UserTripsBloc>(context).add(UserTripsCommitChange(tripChanges: {'departureTime': date, 'id': widget.tripModel.itemId}.tripEditFromJason()));
                    },
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(Icons.edit_note),
                      onPressed: () {
                        _displayTextInputDialog(context,
                            _descriptionControllerDriver, 'описание поездки', 'description');
                      },
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 50,
                    child: Text(
                      'описание: ${_descriptionControllerDriver.text}',
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.font16,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(Icons.edit_note),
                      onPressed: () {
                        _displayTextInputDialog(context,
                            _departurePlaceControllerDriver, 'место отправки', 'departurePlace');
                      },
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 250,
                    child: Text(
                      'Откуда: ${_departurePlaceControllerDriver.text}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.font16,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(Icons.edit_note),
                      onPressed: () {
                        _displayTextInputDialog(context,
                            _arrivalPlaceControllerDriver, 'место прибытия', 'arrivalPlace');
                      },
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 250,
                    child: Text(
                      'Куда: ${_arrivalPlaceControllerDriver.text}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.font16,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  },
);
  }
}
