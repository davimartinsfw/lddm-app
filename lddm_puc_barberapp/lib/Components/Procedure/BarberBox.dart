import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Controllers/ScheduleController.dart';
import 'package:provider/provider.dart';
import '../../Common/Util.dart';
import '../../Models/Procedure/Barber.dart';
import '../../Routes/AppRoutes.dart';
import '../Common/SmallRoundedButton.dart';

class BarberBox extends StatefulWidget {
  final Barber barber;
  final bool shouldShowButton;

  const BarberBox(
      {super.key, required this.barber, this.shouldShowButton = true});

  @override
  State<BarberBox> createState() => _BarberBoxState();
}

class _BarberBoxState extends State<BarberBox> {
  late ScheduleController scheduleController;
  late RouteController routeController;

  @override
  void initState() {
    super.initState();

    scheduleController = context.read<ScheduleController>();
    routeController = context.read<RouteController>();
  }

  Widget renderButton() {
    if (!widget.shouldShowButton) {
      return Container();
    }

    return Container(
        width: Util.getWidth(0.2),
        child: SmallRoundedButton(
            txt: "Agendar",
            callBack: () {
              scheduleController.updateProfessional(widget.barber.name);
              scheduleController.updateProcedureShow(true);

              WidgetsBinding.instance.addPostFrameCallback((_) {
                routeController.softPush(AppRoutes.PROCEDURELIST);
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Util.getWidth(0.4),
      //height: Util.getHeight(0.29),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Util.PrimaryColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: Util.getBoxShadow()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                widget.barber.image,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              )),
          Padding(padding: EdgeInsets.only(bottom: 8)),
          Text(widget.barber.name, style: Util.fontStyleSB()),
          Padding(padding: EdgeInsets.only(bottom: 8)),
          renderButton()
        ],
      ),
    );
  }
}
