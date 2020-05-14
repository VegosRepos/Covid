import 'dart:io';

import 'package:covid/data/remote/exceptions/appExceptions.dart';
import 'package:covid/data/remote/services/baseService.dart';
import 'package:http/http.dart';

class Service extends BaseService {
  final String _baseUrl = "https://api.covid19api.com/";

  Future<dynamic> getMainInfo(String url) async {
    print('Call');
    var responseJson;
    try {
      Response response = await get(_baseUrl + url);
      responseJson = passTheErrorCheck(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
