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

class ProcedureListView extends StatefulWidget {
  const ProcedureListView({super.key});

  @override
  State<ProcedureListView> createState() => _ProcedureListViewState();
}

class _ProcedureListViewState extends State<ProcedureListView> {
  int _counter = 0;
  late RouteController routeController;
  late NavBarController navBarController;

  @override
  void initState() {
    super.initState();

    navBarController = context.read<NavBarController>();
    routeController = context.read<RouteController>();
  }

  @override
  Widget build(BuildContext context) {
 Procedure p =
      Procedure(id: 1, name: "Corte", value: "R\$80,00", duration: "60");

    return Scaffold(
      appBar: HomeHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ProcedureBox(p: p, shouldShowButton: false,)
                
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
