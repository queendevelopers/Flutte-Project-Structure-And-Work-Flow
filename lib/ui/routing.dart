import 'package:entry_assignment/ui/home_view.dart';
import 'package:entry_assignment/ui/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class Routing{
  static const String root='/';
  static const String awesome_page='/awesome_page';
  static const String settings_page='/settings_page';

  static Route<dynamic> generateRoute(RouteSettings settings){
      switch(settings.name){
        case root:
          return MaterialPageRoute(builder: (_)=>ThemeConsumer(child: HomeView(),));
        case awesome_page:
          break;
        case settings_page:
        return MaterialPageRoute(builder: (_)=>ThemeConsumer(child: SettingsPage(),));

        default:
          return MaterialPageRoute(builder: (_)=>Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}'),),
          ));
      }
  }
}