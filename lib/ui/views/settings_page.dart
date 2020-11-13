import 'package:entry_assignment/core/viewmodels/customAppBar.dart';
import 'package:entry_assignment/helper/keys.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:theme_provider/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: 'App Settings',),
              body:  SettingsList(
                  sections: [
                    SettingsSection(
                      title: 'Settings',
                      tiles: [
                        SettingsTile(title:'Home Page',subtitle: 'Bottom Navigation Bar',leading: Icon(Icons.home),),
                        SettingsTile.switchTile(
                          title: 'Use Dark Theme',
                          leading: Icon(Icons.nightlight_round),
                          switchValue: ThemeProvider.themeOf(context).id==Keys.default_dark_theme,
                          onToggle: (bool value) {
                            ThemeProvider.controllerOf(context).nextTheme();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}
