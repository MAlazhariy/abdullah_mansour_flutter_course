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
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': CacheHelper.getToken(),
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
    dio.options.headers = <String, dynamic>{
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': CacheHelper.getToken(),
    };

    return await dio.post(
      path,
      queryParameters: query,
      data: data,
    );
  }
}
