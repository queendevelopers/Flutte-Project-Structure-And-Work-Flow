import 'package:entry_assignment/ui/views/home_view.dart';
import 'package:entry_assignment/ui/views/movies.dart';
import 'package:entry_assignment/ui/views/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class Routing {
  static const String root = '/';
  static const String awesome_page = '/awesome_page';
  static const String settings_page = '/settings_page';
  static const String movies_page = '/movies_page';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(
            builder: (_) => ThemeConsumer(
                  child: HomeView(),
                ));
      case awesome_page:
        break;
      case movies_page:
        return MaterialPageRoute(
            builder: (_) => ThemeConsumer(
                  child: Movies(),
                ));
      case settings_page:
        return MaterialPageRoute(
            builder: (_) => ThemeConsumer(
                  child: SettingsPage(),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
