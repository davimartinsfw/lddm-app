import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/HomeHeader.dart';
import 'package:lddm_puc_barberapp/Common/NavBar.dart';
import 'package:lddm_puc_barberapp/Common/PageHeader.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Components/CalendarView/CalendarSelector.dart';
import 'package:lddm_puc_barberapp/Components/Procedure/BarberBox.dart';
import 'package:lddm_puc_barberapp/Components/Procedure/ProcedureBox.dart';
import 'package:lddm_puc_barberapp/Controllers/NavBarController.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Controllers/ScheduleController.dart';
import 'package:lddm_puc_barberapp/Models/Procedure/Barber.dart';
import 'package:lddm_puc_barberapp/Models/Procedure/Procedure.dart';
import 'package:lddm_puc_barberapp/data/procedureMock.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../data/barbersMock.dart';

class ProcedureListView extends StatefulWidget {
  const ProcedureListView({super.key});

  @override
  State<ProcedureListView> createState() => _ProcedureListViewState();
}

class _ProcedureListViewState extends State<ProcedureListView> {
  int _counter = 0;
  late RouteController routeController;
  late NavBarController navBarController;
  late ScheduleController scheduleController;

  List<Procedure> p = MOCK_PROCEDURE;
  List<Barber> b = MOCK_BARBER;

  @override
  void initState() {
    super.initState();

    navBarController = context.read<NavBarController>();
    routeController = context.read<RouteController>();
    scheduleController = context.read<ScheduleController>();

    renderScreen();
  }

  void renderScreen() {
    if (!scheduleController.shouldShowProfessional &&
        !scheduleController.shouldShowProcedure &&
        !scheduleController.shouldShowCalendar) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scheduleController.updateProcedureShow(true);
      });
    }
  }

  Widget renderBox(Procedure p) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          scheduleController.updateProcedure(p.name);
          scheduleController.updateProcedureShow(false);
          if (scheduleController.professional == null) {
            scheduleController.updateProfessionalShow(true);
            return;
          }
        },
        child: ProcedureBox(
          p: p,
          shouldShowButton: false,
        ),
      ),
    );
  }

  Widget renderBarber(Barber p) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          scheduleController.updateProfessional(p.name);
          scheduleController.updateProfessionalShow(false);
        },
        child: BarberBox(
          barber: p,
          shouldShowButton: false,
        ),
      ),
    );
  }

  Widget renderProcedure() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 16, bottom: 12),
              child: Text(
                "Selecione o serviço:",
                style: Util.fontStyleSB(20),
              ),
            ),
          ],
        ),
        Container(
          height: Util.getHeight(0.72),
          width: Util.getWidth(1),
          child: GridView.count(
            childAspectRatio: 0.98,
            primary: false,
            padding: EdgeInsets.only(bottom: 20, left: 16, right: 8),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              renderBox(p[0]),
              renderBox(p[1]),
              renderBox(p[2]),
              renderBox(p[3]),
              renderBox(p[4]),
            ],
          ),
        ),
      ],
    );
  }

  Widget renderProfessional() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 16, bottom: 12),
              child: Text(
                "Agora escolha o barbeiro:",
                style: Util.fontStyleSB(20),
              ),
            ),
          ],
        ),
        Container(
          height: Util.getHeight(0.72),
          width: Util.getWidth(1),
          child: GridView.count(
            primary: false,
            padding: EdgeInsets.only(bottom: 20, left: 16, right: 8),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              renderBarber(b[0]),
              renderBarber(b[1]),
              renderBarber(b[2]),
              renderBarber(b[3]),
            ],
          ),
        ),
      ],
    );
  }

  Widget renderCalendar() {
    return CalendarSelector();
  }

  Widget renderWidgets() {
    if (scheduleController.shouldShowProcedure) {
      return renderProcedure();
    }

    if (scheduleController.shouldShowProfessional) {
      return renderProfessional();
    }

    return renderCalendar();
  }

  void onPopCustomized() async {
    if (scheduleController.shouldShowProcedure) {
      routeController.softPop();
      return;
    }

    if (scheduleController.shouldShowProfessional) {
      scheduleController.updateProfessionalShow(false);
      scheduleController.updateProcedureShow(true);
      return;
    }

    scheduleController.updateProfessionalShow(true);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ScheduleController>();

    return Scaffold(
      appBar:
          PageHeader("Agendamento", routeController, false, onPopCustomized),
      body: SafeArea(child: renderWidgets()),
      bottomNavigationBar: NavBar(),
    );
  }
}
