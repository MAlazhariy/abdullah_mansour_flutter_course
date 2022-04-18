import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: false,
        // headers: {
        //   'Content-Type': 'application/json',
        // },
      ),
    );
    log('dio object has been created');
  }

  static Future<Response> getDate({
    required String endPoint,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token?? CacheHelper.getToken(),
    };

    return await dio.get(
      endPoint,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = <String, dynamic>{
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token?? CacheHelper.getToken(),
    };

    return await dio.post(
      endPoint,
      queryParameters: query,
      data: data,
    );
  }
}
