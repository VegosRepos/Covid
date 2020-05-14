import 'package:bloc/bloc.dart';
import 'package:covid/bloc/events/descriptionEvent.dart';
import 'package:covid/bloc/states/descriptionStates.dart';

class DescriptionBloc extends Bloc<DescriptionEvents, DescriptionState> {
  @override
  // TODO: implement initialState
  DescriptionState get initialState => null;

  @override
  Stream<DescriptionState> mapEventToState(DescriptionEvents event) {
    // TODO: implement mapEventToState
    return null;
  }
}
