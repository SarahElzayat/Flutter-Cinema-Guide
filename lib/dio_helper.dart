import 'package:dio/dio.dart';

import 'constants/endpoints.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      ),
    );
  }

  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    // print('@Dio helper');
    return await dio.post(path, data: data, queryParameters: query);
  }

  static Future<Response> getData(
      {Map<String, dynamic>? query,
      required String path,
      String? token,
      String? baseUrl}) async {
    if (baseUrl != null) {
      dio.options.baseUrl = baseUrl;
      print('url changed');
    }
    // if (baseUrl == null && dio.options.baseUrl != BASE_URL) {
    //   dio.options.baseUrl = BASE_URL;
    // }

    return await dio.get(
      path,
      queryParameters: query,
    );
  }
}
