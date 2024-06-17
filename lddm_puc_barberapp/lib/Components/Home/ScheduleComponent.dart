import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Controllers/UserController.dart';
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
  late UserController userController;
  String userName = 'Carregando...';

  @override
  void initState() {
    super.initState();

    scheduleController = context.read<ScheduleController>();
    userController = context.read<UserController>();

    fetchUserName();
  }

  Future<void> fetchUserName() async {
    DocumentReference<Map<String, dynamic>> userRef = widget.schedule.userId!;
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await userRef.get();

    if (docSnapshot.exists) {
      setState(() {
        userName = docSnapshot.data()?['name'] ?? 'Não informado';
      });
    } else {
      setState(() {
        userName = 'Não encontrado';
      });
    }
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
                              element.id == widget.schedule.procedureId?.id)
                          .name,
                      style: Util.fontStyleSB(14),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 4)),
                Row(
                  children: [
                    Text(
                      userController.userProfile!.isBarber != null &&
                              userController.userProfile!.isBarber!
                          ? 'Cliente: '
                          : 'Barbeiro: ',
                      style: Util.fontStyle(14),
                    ),
                    Text(
                      userController.userProfile!.isBarber != null &&
                              userController.userProfile!.isBarber!
                          ? userName
                          : scheduleController.barberList
                              .firstWhere((element) =>
                                  element.id == widget.schedule.barberId?.id)
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
                      '${scheduleController.procedureList.firstWhere((element) => element.id == widget.schedule.procedureId?.id).duration} minutos',
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
