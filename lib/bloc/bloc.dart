import 'dart:async';

import 'package:covid/data/remote/models/api_response.dart';
import 'package:covid/models/main_model.dart';
import 'package:covid/repository/repository.dart';

class MainBloc {
  Repository _repository;

  StreamController _streamController;

  StreamSink<ApiResponse<Main_model>> get sink => _streamController.sink;

  Stream<ApiResponse<Main_model>> get stream => _streamController.stream;

  MainBloc() {
    _streamController = StreamController<ApiResponse<Main_model>>();
    _repository = Repository();
    fetchData();
  }

  fetchData() async {
    sink.add(ApiResponse.loading('Fetching covid information'));
    try {
      Main_model model = await _repository.getCovidInfo();
      sink.add(ApiResponse.completed(model));
    } catch (e) {
      sink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _streamController?.close();
  }
}
