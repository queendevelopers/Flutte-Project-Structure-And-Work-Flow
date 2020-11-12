import 'package:entry_assignment/core/viewmodels/basemodel.dart';
import 'package:flutter/material.dart';

class ThemeModel extends BaseModel {
  bool isDark = false;

  void switchTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
