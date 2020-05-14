//class MainBloc {
//  bool isInitialLoading = true;

//  StreamController _streamController;
//
//  StreamSink<ApiResponse<Main_model>> get sink => _streamController.sink;
//
//  Stream<ApiResponse<Main_model>> get stream => _streamController.stream;
//
//  MainBloc() {
//    _streamController = StreamController<ApiResponse<Main_model>>();
//    fetchData();
//  }

//  fetchData() async {
//    if(isInitialLoading) {
//      sink.add(ApiResponse.loading("Wait for last covid information"));
//      isInitialLoading = false;
//    }
//    try {
//      Main_model model = await locator<Repository>().getCovidInfo();
//      sink.add(ApiResponse.completed(model));
//    } catch (e) {
//      sink.add(ApiResponse.error(e.toString()));
//      print(e);
//    }
//  }

//  dispose() {
//    _streamController?.close();
//  }

//}

import 'package:bloc/bloc.dart';
import 'package:covid/bloc/states/mainStates.dart';
import 'package:covid/locator.dart';
import 'package:covid/repository/repository.dart';

import 'events/mainEvents.dart';

class MainBloc extends Bloc<MainEvents, MainState> {
  final Repository repository = locator<Repository>();

  @override
  MainState get initialState => Loading();

  @override
  Stream<MainState> mapEventToState(MainEvents event) async* {
    switch (event) {
      case MainEvents.getMainInfo:
        yield Loading();
        try {
          var result = await repository.getMainInfo();
          yield Completed(result);
        } catch (_) {
          yield Error();
        }
    }
  }
}
