import 'dart:convert';

import 'package:covid/data/remote/services.dart';
import 'package:covid/locator.dart';
import 'package:covid/models/index.dart';

class Repository {
  Future<Main_model> getCountriesInfo() async {
    final response =
        await locator<Services>().getSummaryInfo("https://api.covid19api.com/summary");
    final jsonDecoded = json.decode(response.body);
    Main_model main_model = Main_model.fromJson(jsonDecoded);
    return main_model;
  }
}
