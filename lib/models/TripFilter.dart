class TripFilter {
  final String? date;
  final String? departure;
  final String? arrive;
  final bool type;

  TripFilter({this.date = '', this.departure = '', this.arrive = '', this.type = false});

  Map<String, dynamic> toJson () => {
    'departurePlace': departure,
    'arrivalPlace': arrive,
    'departureTime': date,
  };
}
