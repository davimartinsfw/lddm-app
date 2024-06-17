import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/HomeHeader.dart';
import 'package:lddm_puc_barberapp/Common/NavBar.dart';
import 'package:lddm_puc_barberapp/Components/Home/BarberCarousel.dart';
import 'package:lddm_puc_barberapp/Components/Home/BarberHomeContent.dart';
import 'package:lddm_puc_barberapp/Components/Home/HomeContent.dart';
import 'package:lddm_puc_barberapp/Components/Home/NextSchedule.dart';
import 'package:lddm_puc_barberapp/Components/Home/ProcedureCarousel.dart';
import 'package:lddm_puc_barberapp/Controllers/NavBarController.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Controllers/UserController.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:lddm_puc_barberapp/initializers/AppWidget.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late RouteController routeController;
  late NavBarController navBarController;
  late UserController userController;

  @override
  void initState() {
    super.initState();

    globalContext = context;
    navBarController = context.read<NavBarController>();
    routeController = context.read<RouteController>();
    userController = context.read<UserController>();
    routeController.initialize(navBarController);
    navBarController.initialize(routeController);
  }

  Widget renderContent() {
    if ((userController.userProfile!.isBarber != null &&
        userController.userProfile!.isBarber!) ||
        (userController.userProfile!.isAdmin != null &&
            userController.userProfile!.isAdmin!)) {
        return BarberHomeContent();
    }

    return HomeContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: renderContent(),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
