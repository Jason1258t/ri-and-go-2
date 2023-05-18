import 'package:riandgo2/models/models.dart';

extension ModelsParser on Map<String, dynamic> {
  User parseUser() {
    return User(
        name: this['name'],
        email: this['email'],
        phoneNumber: this['phoneNumber'],
        contactUrl: this['contactUrl']);
  }
}

extension ListModelsParser on List {
  List<TripModel> parseTripList() {
    return List<TripModel>.generate(
        length,
        (index) => TripModel(
            itemId: this[index]['id'],
            itemName: this[index]['name'],
            itemDate: this[index]['departureTime'],
            authorId: this[index]['creatorId'],
            authorName: this[index]['creatorName']?? 'багованная хрень',
            tripType: this[index]['tripType'],
            image: 'Assets/logo.png',
            arrivalPlace: this[index]['arrivalPlace'],
            description: this[index]['description'],
            maxPassengers: this[index]['maxPassengers'],
            departurePlace: this[index]['departurePlace']));
  }
}

//
// extension FutureParser on Future<Map<String, dynamic>> {
//   Map<String, dynamic> parseMap() {
//     Map<String, dynamic> newMap = this;
//   }
// }