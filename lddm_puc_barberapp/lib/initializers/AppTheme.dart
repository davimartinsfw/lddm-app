import 'package:flutter/material.dart';
import '../Common/Util.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Util.BackgroundColor,
  colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Util.getMaterialColor(Colors.black)
  ),
  primarySwatch: Util.getMaterialColor(Util.PrimaryColor),
  fontFamily: 'Poppins'
);