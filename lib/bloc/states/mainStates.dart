import 'package:covid/models/main_model.dart';
import 'package:equatable/equatable.dart';

class MainState extends Equatable {}

class Loading extends MainState {}

class Completed extends MainState {
  final Main_model mainInfo;

  Completed(this.mainInfo);
}

class Error extends MainState {
  final Main_model mainInfo;

  Error(this.mainInfo);
}
