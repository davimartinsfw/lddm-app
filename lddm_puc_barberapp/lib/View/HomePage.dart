import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/HomeHeader.dart';
import 'package:lddm_puc_barberapp/Common/NavBar.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Components/Common/CustomTextField.dart';
import 'package:lddm_puc_barberapp/Components/Common/RoundedButton.dart';
import 'package:lddm_puc_barberapp/Components/Home/BarberCarousel.dart';
import 'package:lddm_puc_barberapp/Components/Home/ProcedureCarousel.dart';
import 'package:lddm_puc_barberapp/Components/Procedure/ProcedureBox.dart';
import 'package:lddm_puc_barberapp/Controllers/NavBarController.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Models/Procedure/Procedure.dart';
import 'package:lddm_puc_barberapp/Models/Profile/Field.dart';
import 'package:lddm_puc_barberapp/Models/Profile/ProfileField.dart';
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

  @override
  void initState() {
    super.initState();

    globalContext = context;
    navBarController = context.read<NavBarController>();
    routeController = context.read<RouteController>();
    routeController.initialize(navBarController);
    navBarController.initialize(routeController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                  child: InkWell(
                    onTap: () {
                      routeController.softPush(AppRoutes.ABOUTUS);
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset('assets/img/clube-teste-1.png')),
                  ),
                ),
                //Padding(padding: EdgeInsets.only(top: 20)),
                ProcedureCarousel(),
                Padding(padding: EdgeInsets.only(top: 20)),
                BarberCarousel()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
