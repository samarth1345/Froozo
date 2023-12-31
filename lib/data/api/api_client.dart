import 'package:flutter/material.dart';
import 'package:froozo/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    debugPrint("output" + appBaseUrl);
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders = {
      'content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      debugPrint("output" + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic data) async {
    print("debug: " + uri);
    try {
      Response response =
          await post(uri, data, headers: _mainHeaders);
      return response;
    } catch (e) {
      debugPrint("output" + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  } 
}
