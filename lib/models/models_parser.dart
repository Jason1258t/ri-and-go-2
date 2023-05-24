import 'package:riandgo2/models/models.dart';
import 'package:riandgo2/services/extensions/custom_extensions.dart';

extension ModelsParser on Map<String, dynamic> {
  User parseUser() {
    return User(
        name: this['name'],
        email: this['email'],
        phoneNumber: this['phoneNumber'],
        contactUrl: this['contactUrl']);
  }

  TripModel parseSingleTrip() {
    final String name = this['name'];
    final String description = this['description'];
    final String arrival = this['arrivalPlace'];
    final String departure = this['departurePlace'];
    return TripModel(
        itemId: this['id'],
        itemName: name.upperCaseFirst(),
        itemDate: this['departureTime'],
        authorId: this['creatorId'],
        authorName: this['creatorName'],
        tripType: this['tripType'],
        image: 'Assets/logo.png',
        departurePlace: departure.capitalizeAll(),
        arrivalPlace: arrival.capitalizeAll(),
        maxPassengers: this['maxPassengers'],
        passengersCount: this['passengersCount'] ?? 0,
        description: description.upperFirstSymbolInSentence());
  }
}

extension ListModelsParser on List {
  List<TripModel> parseTripList() {
    return List<TripModel>.generate(length, (index) {
      final String name = this[index]['name'];
      final String arrival = this[index]['arrivalPlace'];
      final String departure = this[index]['departurePlace'];
      final String description = this[index]['description'];
      final String images = this[index]['imageUrl'] ?? 'https://ih1.redbubble.net/image.343726250.4611/flat,1000x1000,075,f.jpg';
      return TripModel(
        itemId: this[index]['id'],
        itemName: name.upperCaseFirst(),
        itemDate: this[index]['departureTime'],
        authorId: this[index]['creatorId'],
        authorName: this[index]['creatorName'] ?? 'багованная хрень',
        tripType: this[index]['tripType'],
        image: 'Assets/logo.png',
        departurePlace: departure.capitalizeAll(),
        arrivalPlace: arrival.capitalizeAll(),
        description: description.upperFirstSymbolInSentence(),
        maxPassengers: this[index]['maxPassengers'],
        passengersCount: this[index]['passengersCount'] ?? 0,
        images: images.split(' ')
      );
    });
  }
}

//
// extension FutureParser on Future<Map<String, dynamic>> {
//   Map<String, dynamic> parseMap() {
//     Map<String, dynamic> newMap = this;
//   }
// }
