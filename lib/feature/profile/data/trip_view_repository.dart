import 'package:riandgo2/services/api_services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/models.dart';

enum TripViewStateEnum {loading, success, fail}

class TripViewRepository {
  final ApiService apiService;
  TripViewRepository({required this.apiService});

  late TripModel trip;
  BehaviorSubject<TripViewStateEnum> tripViewState = BehaviorSubject<TripViewStateEnum>.seeded(TripViewStateEnum.loading);


  setCurrentTrip(TripModel newTrip) {
    trip = newTrip;
  }
}