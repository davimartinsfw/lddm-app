import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Components/Home/NextSchedule.dart';
import 'package:lddm_puc_barberapp/Components/Home/ScheduleComponent.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Controllers/ScheduleController.dart';
import 'package:lddm_puc_barberapp/Controllers/UserController.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:provider/provider.dart';

class BarberHomeContent extends StatefulWidget {
  const BarberHomeContent({super.key});

  @override
  State<BarberHomeContent> createState() => _BarberHomeContentState();
}

class _BarberHomeContentState extends State<BarberHomeContent> {
  late ScheduleController scheduleController;
  late UserController userController;
  late RouteController routeController;

  @override
  void initState() {
    super.initState();

    scheduleController = context.read<ScheduleController>();
    userController = context.read<UserController>();
    routeController = context.read<RouteController>();

    initializeBarberSchedules();
  }

  void initializeBarberSchedules() async {
    scheduleController.initializeBarberSchedules(userController.userAuth.uid);
  }

  Widget renderList() {
    List<Widget> components = [];

    scheduleController.barberSchedules.forEach((element) {
      components.add(Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
        child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              routeController.softPush(AppRoutes.BARBERSCHEDULEVIEW, element);
            },
            child: ScheduleComponent(schedule: element)),
      ));
    });

    return Column(children: components);
  }

  Widget renderContent() {
    if (scheduleController.barberSchedules.isEmpty) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 8, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Próximos atendimentos:", style: Util.fontStyleSB(20)),
                ],
              )),
          renderList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ScheduleController>();

    return Container(child: renderContent());
  }
}
