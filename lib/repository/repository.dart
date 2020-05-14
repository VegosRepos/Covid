import 'package:covid/data/remote/services/service.dart';
import 'package:covid/locator.dart';
import 'package:covid/models/index.dart';

class Repository {
  final String _apiKey = "summary";

  Service _service = locator<Service>();

  Future<Main_model> getMainInfo() async {
    return await _service.getMainInfo(_apiKey);
  }
}
