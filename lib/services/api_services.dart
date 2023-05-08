// Package imports:
import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:riandgo2/services/exceptions/exceptions.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: '',
    ),
  )..interceptors.add(dioLoggerInterceptor);

  static const String auth = '/auth';
  static const String login = '/login';
  static const String users = '/users';
  static const String register = '/register';


  Future<dynamic> loginUser({required String login, required String password}) async {
    try {
      final userToken = await _dio.get(
          users
        // auth + login + '?email=$login&password=$password',
      );
      return userToken.data;
    } on DioError catch (e) {
      if(e.response?.statusCode == 401){
        throw(UnAuthorizedException);
      }
      if(e.response?.statusCode == 403){
        throw(BadGateWayException);
      }
      if(e.response?.statusCode == 404){
        throw(NotFoundException);
      }
      if(e.response?.statusCode == 500){
        throw(ServerException);
      }
      throw Exception('un known exception');
    }
  }
  Future<dynamic> registerUser({required String login, required String password, required String phone, required String name}) async {
    try {
      final userToken = await _dio.get(
          '$register?emial=$login&password=$password&phone=$phone&name=$name'
        // auth + login + '?email=$login&password=$password',
      );
      return userToken.data;
    } on DioError catch (e) {
      if(e.response?.statusCode == 401){
        throw(UnAuthorizedException);
      }
      if(e.response?.statusCode == 403){
        throw(BadGateWayException);
      }
      if(e.response?.statusCode == 404){
        throw(NotFoundException);
      }
      if(e.response?.statusCode == 500){
        throw(ServerException);
      }
      throw Exception('un known exception');
    }
  }

}
