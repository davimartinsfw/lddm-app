import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../View/HomePage.dart';
import 'AppTheme.dart';
import 'ChangeNotifierProvider.dart';

late BuildContext globalContext;

class NordusApp extends StatelessWidget {
  const NordusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...ChangeNotifierProviders],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      ),
    );
  }
}
