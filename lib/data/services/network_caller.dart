import 'dart:convert';

import 'package:crud_operation_flutter/data/model/network_response_model.dart';
import 'package:http/http.dart';

class NetworkCaller {
  static Future<NetworkResponseModel> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponseModel(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else {
        return NetworkResponseModel(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponseModel(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponseModel> postRequest(String url, {Map<String, dynamic>? body}) async {
    try {
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {'Content-type': 'Application/json'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponseModel(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else {
        return NetworkResponseModel(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponseModel(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}
