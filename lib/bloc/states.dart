import 'package:covid/data/models/Response.dart';
import 'package:covid/presentation/models/Model.dart';
import 'package:equatable/equatable.dart';

class MainState extends Equatable {}

class Loading extends MainState {}

class SuccessResponse extends MainState {
  final Model result;

  SuccessResponse(this.result);
}

class Error extends MainState {}
