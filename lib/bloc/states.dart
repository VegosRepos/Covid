import 'package:covid/models/index.dart';
import 'package:equatable/equatable.dart';

class MainState extends Equatable {}

class Loading extends MainState {}

class SuccessResponse extends MainState {
  final Main_model result;

  SuccessResponse(this.result);
}
