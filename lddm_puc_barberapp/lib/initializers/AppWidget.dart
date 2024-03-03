import 'package:flutter/material.dart';
import '../View/HomePage.dart';
import 'AppTheme.dart';

late BuildContext globalContext;

class NordusApp extends StatelessWidget {
  const NordusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}