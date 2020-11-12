import 'package:entry_assignment/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:entry_assignment/ui/routing.dart';
import 'package:flutter/scheduler.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: false,
      onInitCallback: (controller, previouslySavedThemes) async {
        String savedTheme = await previouslySavedThemes;
        if (savedTheme != null) {
          controller.setTheme(savedTheme);
        } else {
          Brightness platformBrightness =
              SchedulerBinding.instance.window.platformBrightness;
          if (platformBrightness == Brightness.dark) {
            controller.setTheme('dark');
          } else {
            controller.setTheme('light');
          }
          controller.forgetSavedTheme();
        }
      },
      themes: [AppTheme.light(), AppTheme.dark()],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routing.root,
        onGenerateRoute: Routing.generateRoute,
      ),
    );
  }
}
