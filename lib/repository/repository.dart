import 'package:covid/data/remote/services/service.dart';
import 'package:covid/locator.dart';
import 'package:covid/models/index.dart';

class Repository {
  final String _apiKey = "Paste your api key here";

  Service _service = locator<Service>();

  Future<Main_model> getCountriesInfo() async {
    return await _service.getSummaryInfo("summary");
  }
}
