import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Components/Home/NextSchedule.dart';
import 'package:lddm_puc_barberapp/Components/Home/ScheduleComponent.dart';
import 'package:lddm_puc_barberapp/Controllers/ScheduleController.dart';
import 'package:lddm_puc_barberapp/Controllers/UserController.dart';
import 'package:provider/provider.dart';

class BarberHomeContent extends StatefulWidget {
  const BarberHomeContent({super.key});

  @override
  State<BarberHomeContent> createState() => _BarberHomeContentState();
}

class _BarberHomeContentState extends State<BarberHomeContent> {
  late ScheduleController scheduleController;
  late UserController userController;

  @override
  void initState() {
    super.initState();

    scheduleController = context.read<ScheduleController>();
    userController = context.read<UserController>();
    initializeBarberSchedules();
  }

  void initializeBarberSchedules() async {
    scheduleController.initializeBarberSchedules(userController.userProfile.id);
  }

  Widget renderList() {
    List<Widget> components = [];

    scheduleController.barberSchedules.forEach((element) {
      print(scheduleController.barberSchedules[0].barberId);

      components.add(Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ScheduleComponent(schedule: element),
      ));
    });

    return Column(children: components);
  }

  Widget renderContent() {
    if (scheduleController.barberSchedules.isEmpty) {
      return Container();
    }

    return renderList();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ScheduleController>();

    return Container(child: renderContent());
  }
}
