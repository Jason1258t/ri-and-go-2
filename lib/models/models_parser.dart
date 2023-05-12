import 'package:riandgo2/models/models.dart';

import 'UserModel.dart';

extension ModelsParser on Map<String, dynamic> {
  User parseUser() {
    return User(
        name: this['name'],
        email: this['email'],
        phoneNumber: this['phoneNumber'],
        contactUrl: this['contactUrl']
    );
  }
}

extension ListModelsParser on List<Map<String, dynamic>> {
  List<TripModel> parseTripList() {
    return List<TripModel>.generate(this.length, (index) =>
        TripModel(itemId: this[index]['id'],
            itemName: this[index]['name'],
            itemDate: this[index]['departureTime'],
            authorId: this[index]['creatorId'],
            tripType: this[index]['tripType'],
            image: ''));
  }
}