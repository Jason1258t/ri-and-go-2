// Package imports:
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:riandgo2/services/exceptions/exceptions.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://194.67.105.79:5101',
      // baseUrl: '',
    ),
  )..interceptors.add(dioLoggerInterceptor);

  static const String auth = '/auth';
  static const String login = '/Users/Login';
  static const String users = '/users';
  static const String register = '/Users/AddNew';

  Future<dynamic> loginUser(
      {required String email, required String password}) async {
    try {
      print('${login}/$email/$password');
      final userToken = await _dio.get('${login}/$email/$password'
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
}
