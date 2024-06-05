import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Common/MonthsInPortuguese.dart';
import '../../Common/Util.dart';
import '../../Controllers/ScheduleController.dart';
import '../../Models/Schedule/Schedule.dart';

class ScheduleComponent extends StatefulWidget {
  final Schedule schedule;

  const ScheduleComponent({super.key, required this.schedule});

  @override
  State<ScheduleComponent> createState() => _ScheduleComponentState();
}

class _ScheduleComponentState extends State<ScheduleComponent> {
  late ScheduleController scheduleController;

  @override
  void initState() {
    super.initState();

    scheduleController = context.read<ScheduleController>();
  }

  String add0(int i) {
    return i < 10 ? '0$i' : i.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Util.getWidth(0.91),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Util.PrimaryColor),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(21),
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Util.SecondaryColor),
            child: Column(
              children: [
                Text(
                  "${add0(widget.schedule.horario!.hour)}:${add0(widget.schedule.horario!.minute)}",
                  style: Util.fontStyleSB(20, Util.PrimaryColor),
                ),
                Text(
                  "${add0(widget.schedule.horario!.day)}/${MonthsInPortuguese().witchShortMonth(widget.schedule.horario!.month)}",
                  style: Util.fontStyle(14, Util.PrimaryColor),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 21, top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Serviço: ',
                      style: Util.fontStyle(14),
                    ),
                    Text(
                      scheduleController.procedureList
                          .firstWhere((element) =>
                              element.id == widget.schedule.procedureId)
                          .name,
                      style: Util.fontStyleSB(14),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 4)),
                Row(
                  children: [
                    Text(
                      'Barbeiro: ',
                      style: Util.fontStyle(14),
                    ),
                    Text(
                      scheduleController.barberList
                          .firstWhere((element) =>
                              element.id == widget.schedule.barberId)
                          .name,
                      style: Util.fontStyleSB(14),
                      maxLines: 1,
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 4)),
                Row(
                  children: [
                    Text(
                      'Duração: ',
                      style: Util.fontStyle(14),
                    ),
                    Text(
                      scheduleController.procedureList
                              .firstWhere((element) =>
                                  element.id == widget.schedule.procedureId)
                              .duration
                              .toString() +
                          ' minutos',
                      style: Util.fontStyleSB(14),
                      maxLines: 1,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
