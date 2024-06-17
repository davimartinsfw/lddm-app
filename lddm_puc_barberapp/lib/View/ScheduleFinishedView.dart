import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Controllers/ScheduleController.dart';
import 'package:lddm_puc_barberapp/Controllers/UserController.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:provider/provider.dart';

import '../Controllers/RouteController.dart';

class ScheduleFinishedView extends StatefulWidget {
  const ScheduleFinishedView({super.key});

  @override
  State<ScheduleFinishedView> createState() => _ScheduleFinishedViewState();
}

class _ScheduleFinishedViewState extends State<ScheduleFinishedView> {
  late RouteController routeController;
  late ScheduleController scheduleController;
  late UserController userController;

  @override
  void initState() {
    super.initState();

    routeController = context.read<RouteController>();
    scheduleController = context.read<ScheduleController>();
    userController = context.read<UserController>();
    redirect();
  }

  void redirect() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 1200));
      scheduleController.resetSchedule();
    });

    await userController.initializeUserSchedule();
    routeController.softPush(AppRoutes.HOME);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/check-circle.png'),
            Container(
              width: Util.getWidth(0.5),
              child: Text(
                'Agendamento confirmado!',
                style: Util.fontStyleSB(25),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: Util.getWidth(0.5),
              child: Text(
                'Nos vemos em breve!',
                style: Util.fontStyle(16),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
