class TripModel {
  String itemName;
  String itemDate;
  int authorId;
  String authorName;
  int itemId;
  bool tripType;
  String image;
  String departurePlace;
  String arrivalPlace;
  String description;
  int maxPassengers;
  int passengersCount;
  bool followed;

  TripModel(
      {required this.itemId,
      required this.itemName,
      required this.itemDate,
      required this.authorId,
      required this.authorName,
      required this.tripType,
      required this.image,
      required this.departurePlace,
      required this.arrivalPlace,
      required this.maxPassengers,
      required this.passengersCount,
      required this.description,
      this.followed = false});
}

class AddTripModel {
  final String name;
  final String description;
  //final int creatorId;
  final bool isActive = true;
  final DateTime departureTime;
  final String departurePlace;
  final String arrivalPlace;
  final bool tripType;
  final String? maxPassengers;

  AddTripModel(
      {required this.name,
      required this.description,
      //required this.creatorId,
      required this.departureTime,
      required this.departurePlace,
      required this.arrivalPlace,
      required this.tripType,
      required this.maxPassengers});

  Map<String, dynamic> toJson (int creatorId) =>
      {
        "name": name,
        "description": description,
        "creatorId": creatorId,
        "isActive": true,
        "departureTime": departureTime.toString().split(' ')[0],
        "departurePlace": departurePlace,
        "arrivalPlace": arrivalPlace,
        "tripType": tripType,
        "maxPassengers": (maxPassengers != null) ?  int.parse(maxPassengers ?? '1') : null
      };
}

// "name": _textFieldController4.text,
// "description": _textFieldController5.text,
// "creatorId": context.read<Repository>().id,
// "isActive": true,
// "departureTime": _textFieldController3.text,
// "departurePlace":_textFieldController1.text,
// "arrivalPlace": _textFieldController2.text,
// "tripType": false,
// "maxPassengers": 1

//{id: , name: , description: , creatorId: , isActive: , departureTime: , departurePlace: , arrivalPlace: , tripType: , maxPassengers: , imageUrl: null}
