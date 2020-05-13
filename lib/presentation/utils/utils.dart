import 'package:covid/models/country_model.dart';
import 'package:covid/models/main_model.dart';

List<Country_model> sortCountriesByConfirmed(Main_model mainModel) {
  mainModel.Countries.sort(
      (a, b) => a.TotalConfirmed.compareTo(b.TotalConfirmed));
  final sortedList = mainModel.Countries.reversed.toList();
  return sortedList;
}