import 'package:http/http.dart';

class Services {
  Future<Response> getSummaryInfo(String link) async {
    try {
      Response response = await get(link);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
