import 'package:covid/presentation/pages/description.dart';
import 'package:covid/repository/repository.dart';
import 'package:get_it/get_it.dart';

import 'bloc/bloc.dart';
import 'data/remote/services/service.dart';
import 'models/country_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(Service());
  locator.registerSingleton(Repository());
  locator.registerSingleton(MainBloc());
  locator.registerSingleton(Country_model());
}