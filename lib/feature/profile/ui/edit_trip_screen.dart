import 'package:flutter/material.dart';
import 'package:riandgo2/models/TripModel.dart';

class EditTrip extends StatefulWidget {
  EditTrip({
    Key? key,
  }) : super(key: key);

  @override
  State<EditTrip> createState() => _EditTripState();
}

class _EditTripState extends State<EditTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактирование'),
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
              border: Border.all(
                color: Colors.white10,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                        'Assets/logo.png'), // TODO подгрузка с сервера
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                        'Assets/logo.png'), // TODO подгрузка с сервера
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(icon: Icon(Icons.edit_note), onPressed: () { },),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                        'Assets/aboba.png'), // TODO подгрузка с сервера
                  ),
                  Text('Поездка: yfpdfybt}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(icon: Icon(Icons.edit_note), onPressed: () { },),
                  ),
                  Text('12/11/2022'), // TODO dateTime
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(icon: Icon(Icons.edit_note), onPressed: () { },),
                  ),
                  Text(
                      'yfpdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfybt',
                      softWrap: true,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(icon: Icon(Icons.edit_note), onPressed: () { },),
                  ),
                     Text(
                        'Откуда: ',
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                      ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(icon: Icon(Icons.edit_note), onPressed: () { },),
                  ),
                  Text(
                      'Куда: ',
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(icon: Icon(Icons.edit_note), onPressed: () { },),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.people),
                  ),
                  Text(
                    '3/5',
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
