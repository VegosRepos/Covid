import 'dart:convert';
import 'dart:io';

import 'package:covid/data/remote/exceptions/app_exceptions.dart';
import 'package:covid/models/main_model.dart';
import 'package:http/http.dart';

class Service {

  final String _baseUrl = "https://api.covid19api.com/";

  Future<dynamic> getCovidInfo(String url) async {
    var responseJson;
    try {
      Response response = await get(_baseUrl + url);
      responseJson = _checkResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _checkResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        final jsonDecoded = json.decode(response.body);
        Main_model mainModel = Main_model.fromJson(jsonDecoded);
        return mainModel;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }
}
