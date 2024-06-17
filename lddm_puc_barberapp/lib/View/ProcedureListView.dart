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
import 'package:provider/provider.dart';

class ProcedureListView extends StatefulWidget {
  const ProcedureListView({super.key});

  @override
  State<ProcedureListView> createState() => _ProcedureListViewState();
}

class _ProcedureListViewState extends State<ProcedureListView> {
  late RouteController routeController;
  late NavBarController navBarController;
  late ScheduleController scheduleController;

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

  List<Widget> renderProcedureList() {
    List<Widget> list = [];

    scheduleController.procedureList.forEach((element) {
      list.add(renderBox(element));
    });

    return list;
  }

  List<Widget> renderBarberList() {
    List<Widget> list = [];
    int counter = 0;

    scheduleController.barberList.forEach((element) {
      list.add(renderBarber(element, counter));
      counter++;
    });

    return list;
  }

  Widget renderBox(Procedure p) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          scheduleController.updateProcedure(p.id);
          scheduleController.updateProcedureShow(false);
          if (scheduleController.actualSchedule.barberId == null) {
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

  Widget renderBarber(Barber p, int counter) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          scheduleController.updateProfessional(p.id);
          scheduleController.updateProfessionalShow(false);
        },
        child: BarberBox(
          barber: p,
          shouldShowButton: false,
          photoId: counter,
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
            children: renderProcedureList(),
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
            children: renderBarberList(),
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
