import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/MonthsInPortuguese.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Controllers/ScheduleController.dart';
import 'package:lddm_puc_barberapp/Controllers/UserController.dart';
import 'package:provider/provider.dart';

class NextSchedule extends StatefulWidget {
  const NextSchedule({super.key});

  @override
  State<NextSchedule> createState() => _NextScheduleState();
}

class _NextScheduleState extends State<NextSchedule> {
  late UserController userController;
  late ScheduleController scheduleController;

  @override
  void initState() {
    super.initState();

    userController = context.read<UserController>();
    scheduleController = context.read<ScheduleController>();
  }

  String add0(int i) {
    return i < 10 ? '0$i' : i.toString();
  }

  Widget renderComponent() {
    if (userController.userSchedule.isEmpty) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Seu próximo agendamento", style: Util.fontStyleSB(20))
              ],
            ),
          ),
          Container(
            width: Util.getWidth(0.91),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Util.PrimaryColor),
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
                        "${add0(userController.userSchedule[0].horario!.hour)}:${add0(userController.userSchedule[0].horario!.minute)}",
                        style: Util.fontStyleSB(20, Util.PrimaryColor),
                      ),
                      Text(
                        "${add0(userController.userSchedule[0].horario!.day)}/${MonthsInPortuguese().witchShortMonth(userController.userSchedule[0].horario!.month)}",
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
                                    element.id ==
                                    userController.userSchedule[0].procedureId)
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
                                    element.id ==
                                    userController.userSchedule[0].barberId)
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
                                        element.id ==
                                        userController
                                            .userSchedule[0].procedureId)
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return renderComponent();
  }
}
