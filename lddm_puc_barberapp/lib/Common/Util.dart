import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/initializers/AppWidget.dart';

class Util {
  static const PrimaryColor = Color.fromRGBO(255, 255, 255, 1);
  static const SecondaryColor = Color.fromRGBO(234, 113, 76, 1);
  static const BackgroundColor = Color.fromRGBO(248, 243, 240, 1);
  static const HeaderArrow = Color.fromRGBO(200, 200, 200, 1);
  static const TextColor = Color.fromRGBO(100, 100, 100, 1);
  static const BorderColor = Color.fromRGBO(187, 187, 187, 1);
  static const DisableCalendar = Color.fromRGBO(236, 236, 236, 1);
  static const DangerColor = Color.fromRGBO(255, 61, 0, 1);
  static const InputColor = Color.fromRGBO(166, 166, 171, 1);

  static MaterialColor getMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  static List<BoxShadow> getBoxShadow() {
    return [
      BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.06),
          blurRadius: 4,
          offset: Offset(0, 2)),
      BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: 6,
          offset: Offset(0, 4))
    ];
  }

  static double getWidth(double d) {
    return MediaQuery.of(globalContext).size.width * d;
  }

  static double getHeight(double d) {
    return MediaQuery.of(globalContext).size.height * d;
  }

  static TextStyle fontStyle([double d = 15, Color? color = TextColor]) {
    return TextStyle(fontSize: d, color: color);
  }

  static TextStyle fontStyleSB([double d = 15, Color? color = TextColor]) {
    return TextStyle(fontSize: d, color: color, fontWeight: FontWeight.w600);
  }

  static TextStyle fontStyleB([double d = 15, Color? color = PrimaryColor]) {
    return TextStyle(fontSize: d, color: color, fontWeight: FontWeight.w700);
  }
}