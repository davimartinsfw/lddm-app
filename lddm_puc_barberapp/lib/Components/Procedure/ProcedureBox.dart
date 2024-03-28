import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Components/Common/RoundedButton.dart';
import 'package:lddm_puc_barberapp/Components/Common/SmallRoundedButton.dart';
import 'package:lddm_puc_barberapp/Models/Procedure/Procedure.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:provider/provider.dart';

import '../../Controllers/RouteController.dart';
import '../../Controllers/ScheduleController.dart';

class ProcedureBox extends StatefulWidget {
  final Procedure p;
  final bool shouldShowButton;

  const ProcedureBox(
      {super.key, required this.p, this.shouldShowButton = true});

  @override
  State<ProcedureBox> createState() => _ProcedureBoxState();
}

class _ProcedureBoxState extends State<ProcedureBox> {
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

    return Column(
      children: [
        Padding(padding: EdgeInsets.only(bottom: 8)),
        Container(
            width: Util.getWidth(0.2),
            child: SmallRoundedButton(txt: "Agendar", callBack: () {
                scheduleController.updateProcedure(widget.p.name);
                scheduleController.updateProfessionalShow(true);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  routeController.softPush(AppRoutes.PROCEDURELIST);
                });
            })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Util.getWidth(0.4),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Util.PrimaryColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: Util.getBoxShadow()),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                  child: Image.asset("assets/img/clube-teste-1.png"))),
          Padding(padding: EdgeInsets.only(bottom: 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.p.name, style: Util.fontStyleSB()),
            ],
          ),
          Row(
            children: [
              Text(widget.p.duration + " min",
                  style: Util.fontStyle(11, Util.HeaderArrow)),
              Text(" • ", style: Util.fontStyle(11, Util.HeaderArrow)),
              Text(widget.p.value, style: Util.fontStyle(11, Util.HeaderArrow)),
            ],
          ),
          renderButton()
        ],
      ),
    );
  }
}
