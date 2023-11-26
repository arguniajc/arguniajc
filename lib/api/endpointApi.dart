// ignore_for_file: file_names

import 'package:dio/dio.dart';

class EndPointApi {
  static Dio dio = Dio();

  static void configureDio() {
    // Base del Url
    dio.options.baseUrl = 'https://localhost:7275/api/';
    // Configurar Headers
    //_dio.options.headers = {
    //  '': ''
    //};
  }

  static Future httpGet(String path) async {
    try {
      final resp = await dio.get(path);
      return resp.data;
    } on DioException catch (e) {
      throw ('Error en el Get $e');
    }
  }

  static Future httpPost(String path, Map<String, dynamic> data) async {
    //final formData = FormData.fromMap(data);

    try {
      final resp = await dio.post(path, data: data);
      return resp.data;
    } on DioException catch (e) {
      throw ('Error en el Post $e');
    }
  }

  static Future httpPut(String path, Map<String, dynamic> data) async {
    //final formData = FormData.fromMap(data);

    try {
      final resp = await dio.put(path, data: data);
      return resp.data;
    } on DioException catch (e) {
      throw ('Error en el put $e');
    }
  }

  static Future httpPutSinBody(String path) async {
    //final formData = FormData.fromMap(data);

    try {
      final resp = await dio.put(path);
      return resp.data;
    } on DioException catch (e) {
      throw ('Error en el put $e');
    }
  }

  static Future httpDelete(String path) async {
    try {
      final resp = await dio.delete(path);
      return resp.data;
    } on DioException catch (e) {
      throw ('Error en el Delete $e');
    }
  }
}
