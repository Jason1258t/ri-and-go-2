class TripEditModel {
  final int id;
  final String? name;
  final String? description;
  final String? departurePlace;
  final String? arrivalPlace;
  final DateTime? departureTime;

  TripEditModel({this.name, this.description, this.departurePlace, this.arrivalPlace, this.departureTime, required this.id});


  Map<String, dynamic> toJson () {
    return {
      'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (departurePlace != null) 'departurePlace': departurePlace,
      if (arrivalPlace != null) 'arrivalPlace': arrivalPlace,
      if (departureTime != null) 'departureTime': departureTime.toString().split(' ')[0],
    };
  }

}


extension TripEditFromJson on Map<String, dynamic> {
  TripEditModel tripEditFromJason () =>
    TripEditModel(name: this['name'], description: this['description'], departurePlace: this['departurePlace'], arrivalPlace: this['arrivalPlace'], departureTime: this['departureTime'], id: this['id']);
}