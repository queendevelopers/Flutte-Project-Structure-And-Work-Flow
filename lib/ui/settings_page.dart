import 'package:entry_assignment/core/config.dart';
import 'package:entry_assignment/core/viewmodels/thememodel.dart';
import 'package:entry_assignment/views/BaseView.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:theme_provider/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ThemeModel>(
        builder: (context, themeModel, child) => Scaffold(
              body: SettingsList(
                sections: [
                  SettingsSection(
                    title: 'Settings',
                    tiles: [
                      SettingsTile.switchTile(
                        title: 'Use Dark Theme',
                        leading: Icon(Icons.nightlight_round),
                        switchValue: themeModel.isDark,
                        onToggle: (bool value) {
                          themeModel.switchTheme();
                          ThemeProvider.controllerOf(context).nextTheme();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}
