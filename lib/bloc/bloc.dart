import 'package:bloc/bloc.dart';
import 'package:covid/bloc/events.dart';
import 'package:covid/locator.dart';
import 'package:covid/repository/repository.dart';

import 'states.dart';

class MainBloc extends Bloc<Events, MainState> {

  @override
  MainState get initialState => Loading();

  @override
  Stream<MainState> mapEventToState(Events event) async* {
    switch (event) {
      case Events.getSummaryInfo:
        try {
          var result = await locator<Repository>().getCountriesInfo();
          yield SuccessResponse(result);
        } catch (_) {
          print('An error occured');
        }
    }
  }
}
