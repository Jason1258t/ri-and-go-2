class TripFilter {
  final String? date;
  final String? departure;
  final String? arrive;
  final bool type;

  TripFilter({this.date, this.departure, this.arrive, this.type = false});

  Map<String, dynamic> toJson () => {
    if (departure != null) 'departurePlace': departure,
    if (arrive != null) 'arrivalPlace': arrive,
    if (date != null) 'departureTime': date,
    'tripType': type,
  };
}
