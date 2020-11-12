import 'package:entry_assignment/core/viewmodels/homemodel.dart';
import 'package:entry_assignment/core/viewmodels/thememodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator=GetIt.instance;

void setUpLocator(){
  locator.registerFactory(() => ThemeModel());
  locator.registerLazySingleton(() => HomeModel());
}