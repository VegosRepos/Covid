import 'dart:convert';

import 'package:covid/data/models/Response.dart';
import 'package:covid/data/remote/services.dart';
import 'package:covid/presentation/models/Model.dart';

class Repository {
  Future<Model> getCountriesInfo() async {
    final response =
        await Services().getSummaryInfo("https://api.covid19api.com/summary");
    List<Country> countries = parsedCountries(response);
    Global global = parsedGlobal(response);
    return Model(countries, global);
  }

  List<Country> parsedCountries(final response) {
    final jsonDecoded = json.decode(response.body)['Countries'] as List;
    List<Country> countries = jsonDecoded
        .map((countryJson) => Country.fromJson(countryJson))
        .toList();
    return countries;
  }

  Global parsedGlobal(final response) {
    final jsonDecoded = json.decode(response.body)['Global'];
    Global global = Global.fromJson(jsonDecoded);
    return global;
  }
}
