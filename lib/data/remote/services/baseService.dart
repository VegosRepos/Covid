import 'dart:convert';

import 'package:covid/data/remote/exceptions/app_exceptions.dart';
import 'package:covid/models/main_model.dart';
import 'package:http/http.dart';

abstract class BaseService {
  dynamic passTheErrorCheck(Response response) {
    switch (response.statusCode) {
      case 200:
        final jsonDecoded = json.decode(response.body);
        Main_model mainModel = Main_model.fromJson(jsonDecoded);
        print('Success');
        return mainModel;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('An error occurred');
    }
  }
}
