import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'initializers/AppWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int? userId = sharedPreferences.getInt('userId');

  final String initialRoute =
      userId != null ? AppRoutes.HOMELOADING : AppRoutes.LOGIN;

  runApp(NordusApp(initialRoute));
}
