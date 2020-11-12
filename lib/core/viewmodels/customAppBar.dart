import 'package:entry_assignment/core/customcolors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({key, title, context, actionsItems})
      : super(
            key: key,
      leading:  ImageIcon(AssetImage('assets/images/Genius_logo.png')),
      titleSpacing: 2,
      backgroundColor: CustomColors.primary_color,
      title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: actionsItems ?? actionsItems);
}
