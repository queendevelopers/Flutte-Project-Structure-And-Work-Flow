import 'package:entry_assignment/core/viewmodels/GitHubViewModel.dart';
import 'package:entry_assignment/core/viewmodels/MoviesViewModel.dart';
import 'package:entry_assignment/core/viewmodels/homemodel.dart';
import 'package:entry_assignment/core/viewmodels/news_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerFactory(() => MoviesViewModel());
  locator.registerFactory(() => NewsViewModel());
  locator.registerFactory(() => GitHubViewModel());
}
