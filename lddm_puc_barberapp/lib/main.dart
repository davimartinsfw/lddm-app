import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'initializers/AppWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int? userId = sharedPreferences.getInt('userId');
  await Firebase.initializeApp();

  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  await FirebaseAuth.instance.signOut();

  String initialRoute = FirebaseAuth.instance.currentUser == null
      ? AppRoutes.LOGIN
      : AppRoutes.HOMELOADING;

  runApp(NordusApp(initialRoute));
}
