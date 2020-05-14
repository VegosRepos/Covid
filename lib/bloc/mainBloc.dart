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
        try {
          var result = await repository.getMainInfo();
          yield Completed(result);
        } catch (_) {
          yield Error();
        }
    }
  }
}
