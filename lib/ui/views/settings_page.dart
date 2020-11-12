import 'package:entry_assignment/helper/keys.dart';
import 'package:entry_assignment/ui/views/BaseView.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:theme_provider/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
              body: SettingsList(
                sections: [
                  SettingsSection(
                    title: 'Settings',
                    tiles: [
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
              )
    );
  }
}
