import 'package:entry_assignment/core/viewmodels/homemodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator=GetIt.instance;

void setUpLocator(){
  locator.registerLazySingleton(() => HomeModel());
}