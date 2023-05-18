// Package imports:

import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riandgo2/models/TripEditModel.dart';
import 'package:riandgo2/models/models.dart';

// Project imports:
import 'package:riandgo2/services/exceptions/exceptions.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://194.67.105.79:5101',
      sendTimeout: 10,
      // baseUrl: '',
    ),
  )..interceptors.add(dioLoggerInterceptor);

  static const String auth = '/auth';
  static const String login = '/Users/Login';
  static const String users = '/users';
  static const String register = '/Users/AddNew';
  static const String profile = '/Users/Get/';
  static const String profileEdit = '/Users/SetUser';
  static const String userTrips = '/Trips/GetUserTrips/';
  static const String trips = '/Trips/GetAll';
  static const String filteredTrips = '/Trips/FetchTrips';
  static const String tripAdd = '/Trips/AddNew';
  static const String tripDelete = '/Trips/SetActive';
  static const String tripEdit = '/Trips/Edit';

  Future<dynamic> loginUser(
      {required String email, required String password}) async {
    try {
      final userToken = await _dio.get('${login}/$email/$password'
          // auth + login + '?email=$login&password=$password',
          );
      return userToken.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw (UnAuthorizedException);
      }
      if (e.response?.statusCode == 403) {
        throw (BadGateWayException);
      }
      if (e.response?.statusCode == 404) {
        throw (NotFoundException);
      }
      if (e.response?.statusCode == 500) {
        throw (ServerException);
      }
      throw Exception('un known exception');
    }
  }

  Future<dynamic> registerUser(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    try {
      final userToken = await _dio.post(register, data: {
        'email': email,
        'phoneNumber': phone,
        'name': name,
        'password': password,
      }
          // auth + login + '?email=$login&password=$password',
          );
      return true;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw (UnAuthorizedException);
      }
      if (e.response?.statusCode == 403) {
        throw (BadGateWayException);
      }
      if (e.response?.statusCode == 404) {
        throw (NotFoundException);
      }
      if (e.response?.statusCode == 500) {
        throw (ServerException);
      }
      throw Exception('un known exception');
    }
  }

  Future<Map<String, dynamic>> loadProfile({required int id}) async {
    try {
      final userInfo = await _dio.get(profile + id.toString());
      return userInfo.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw (UnAuthorizedException);
      }
      if (e.response?.statusCode == 403) {
        throw (BadGateWayException);
      }
      if (e.response?.statusCode == 404) {
        throw (NotFoundException);
      }
      if (e.response?.statusCode == 500) {
        throw (ServerException);
      }
      throw Exception('un known exception');
    }
  }

  Future<void> editProfile({required Map newInfo}) async {
    try {
      await _dio.post(profileEdit, data: newInfo);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw (UnAuthorizedException);
      }
      if (e.response?.statusCode == 403) {
        throw (BadGateWayException);
      }
      if (e.response?.statusCode == 404) {
        throw (NotFoundException);
      }
      if (e.response?.statusCode == 500) {
        throw (ServerException);
      }
      throw Exception('un known exception');
    }
  }

  Future<dynamic> loadUserTrips({required int id}) async {
    try {
      final userTripsResp = await _dio.get(userTrips + id.toString());
      return userTripsResp.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw (UnAuthorizedException);
      }
      if (e.response?.statusCode == 403) {
        throw (BadGateWayException);
      }
      if (e.response?.statusCode == 404) {
        throw (NotFoundException);
      }
      if (e.response?.statusCode == 500) {
        throw (ServerException);
      }
      throw Exception('un known exception');
    }
  }

  FutureOr<String> loadCreatorName(int id) async {
    try {
      final userInfo = await _dio.get(profile + id.toString());
      return userInfo.data['name'];
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw (UnAuthorizedException);
      }
      if (e.response?.statusCode == 403) {
        throw (BadGateWayException);
      }
      if (e.response?.statusCode == 404) {
        throw (NotFoundException);
      }
      if (e.response?.statusCode == 500) {
        throw (ServerException);
      }
      throw Exception('un known exception');
    }
  }

  Future<dynamic> defaultLoadTrips() async {
    try {
      final loadedTrips = await _dio.get(trips).then((value) async => await loadTripsCreators(value.data));
      return loadedTrips;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw (UnAuthorizedException);
      }
      if (e.response?.statusCode == 403) {
        throw (BadGateWayException);
      }
      if (e.response?.statusCode == 404) {
        throw (NotFoundException);
      }
      if (e.response?.statusCode == 500) {
        throw (ServerException);
      }
      throw Exception('un known exception');
    }
  }

  Future<List> loadTripsCreators(List tripList) async {
    log(tripList.toString());
    List toReturn = [];
    for (var element in tripList) {
      try {
        final String name = await loadCreatorName(element['creatorId']);
        log(name.toString());
        element['creatorName'] = name;
        toReturn.add(element);
        log(element.toString());
      } catch (e) {
        log(e.toString());
      }
    }
    log(toReturn.toString());
    return toReturn;
  }

  Future<dynamic> filteredLoadTrips(TripFilter filter) async {
    try {
      List loadedTrips = await _dio.post(filteredTrips, data: filter.toJson()).then((value) async => await loadTripsCreators(value.data));
      return loadedTrips;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw (UnAuthorizedException);
      }
      if (e.response?.statusCode == 403) {
        throw (BadGateWayException);
      }
      if (e.response?.statusCode == 404) {
        throw (NotFoundException);
      }
      if (e.response?.statusCode == 500) {
        throw (ServerException);
      }
      throw Exception('un known exception');
    }
  }

  Future<void> addTrip(Map trip) async {
    try {
      await _dio.post(tripAdd, data: trip);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw (UnAuthorizedException);
      }
      if (e.response?.statusCode == 403) {
        throw (BadGateWayException);
      }
      if (e.response?.statusCode == 404) {
        throw (NotFoundException);
      }
      if (e.response?.statusCode == 500) {
        throw (ServerException);
      }
      rethrow;
    }
  }

  Future<void> deleteTrip({required int tripId}) async {
    try {
      await _dio.post(tripDelete, data: {'tripId': tripId, 'isActive': false});
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw (UnAuthorizedException);
      }
      if (e.response?.statusCode == 403) {
        throw (BadGateWayException);
      }
      if (e.response?.statusCode == 404) {
        throw (NotFoundException);
      }
      if (e.response?.statusCode == 500) {
        throw (ServerException);
      }
      rethrow;
    }
  }

  Future<void> editTrip({required TripEditModel tripEditModel}) async {
    try {
      final resp = await _dio.post(tripEdit, data: tripEditModel.toJson());
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw (UnAuthorizedException);
      }
      if (e.response?.statusCode == 403) {
        throw (BadGateWayException);
      }
      if (e.response?.statusCode == 404) {
        throw (NotFoundException);
      }
      if (e.response?.statusCode == 500) {
        throw (ServerException);
      }
      rethrow;
    }
  }
}
