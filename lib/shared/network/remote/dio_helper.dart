import 'dart:developer';

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: false,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    log('dio object has been created');
  }

  static Future<Response> getDate({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    String? token,
    Map<String, dynamic>? query,
    String lang = 'ar',
  }) async {
    dio.options.headers = <String, dynamic>{
      'lang': lang,
    };

    return await dio.post(
      path,
      queryParameters: query,
      data: data,
    );
  }
}
