import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/HomeHeader.dart';
import 'package:lddm_puc_barberapp/Common/NavBar.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Components/Procedure/ProcedureBox.dart';
import 'package:lddm_puc_barberapp/Controllers/NavBarController.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Models/Procedure/Procedure.dart';
import 'package:provider/provider.dart';

class CutsView extends StatefulWidget {
  const CutsView({super.key});

  @override
  State<CutsView> createState() => _CutsView();
}

class _CutsView extends State<CutsView> {
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
            child: GridView.count(
              primary: false,

              padding: EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: [ProcedureBox(p: p, shouldShowButton: false,),ProcedureBox(p: p, shouldShowButton: false,),ProcedureBox(p: p, shouldShowButton: false,),ProcedureBox(p: p, shouldShowButton: false,),ProcedureBox(p: p, shouldShowButton: false,),ProcedureBox(p: p, shouldShowButton: false,)
              ],
            ),
        ),
      bottomNavigationBar: NavBar(),
    );
  }
}