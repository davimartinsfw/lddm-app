import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:lddm_puc_barberapp/View/Login/LoginView.dart';
import 'package:provider/provider.dart';
import '../Routes/CustomRouter.dart';
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
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          title: 'Flutter Demo',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.generateRoute,
          initialRoute: AppRoutes.LOGIN,
          //home: const LoginView(),
          supportedLocales: [const Locale('pt', 'BR')]),
    );
  }
}
