import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/NavBar.dart';
import 'package:lddm_puc_barberapp/Common/PageHeader.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Components/Common/RoundedButton.dart';
import 'package:lddm_puc_barberapp/Components/Home/ScheduleComponent.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Controllers/ScheduleController.dart';
import 'package:lddm_puc_barberapp/Controllers/UserController.dart';
import 'package:lddm_puc_barberapp/Models/Schedule/Schedule.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'ImageBottomModal.dart';

class Barberscheduleview extends StatefulWidget {
  final Schedule schedule;

  const Barberscheduleview({super.key, required this.schedule});

  @override
  State<Barberscheduleview> createState() => _BarberscheduleviewState();
}

class _BarberscheduleviewState extends State<Barberscheduleview> {
  late RouteController routeController;
  late ScheduleController scheduleController;
  late UserController userController;

  @override
  void initState() {
    super.initState();

    routeController = context.read<RouteController>();
    scheduleController = context.read<ScheduleController>();
    userController = context.read<UserController>();
  }

  Widget renderPhotoBox(String? image) {
    bool condition = image == null;

    return IgnorePointer(
      ignoring: condition,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          showBarModalBottomSheet(
              context: context,
              builder: (context) => ImageBottomModal(imageUrl: image!));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          condition ? Util.HeaderArrow : Util.SecondaryColor),
                  borderRadius: BorderRadius.circular(8)),
              child: Text('Ver foto',
                  style: Util.fontStyleSB(
                      12, condition ? Util.HeaderArrow : Util.SecondaryColor)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageHeader('Agendamento', routeController),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 12, left: 16, right: 16, top: 20),
                child: ScheduleComponent(schedule: widget.schedule),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Cabelo atual do cliente:",
                            style: Util.fontStyleSB()),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 8)),
                    renderPhotoBox(widget.schedule.fotoAtual)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 30, bottom: 80),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Corte referência do cliente:",
                            style: Util.fontStyleSB()),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 8)),
                    renderPhotoBox(widget.schedule.fotoCorte)
                  ],
                ),
              ),
              Container(
                width: Util.getWidth(0.6),
                child: RoundedButton(
                    color: Util.DangerColor,
                    text: 'Cancelar agendamento',
                    callBackOnPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('schedule')
                          .doc(widget.schedule.id)
                          .delete();
                      await scheduleController.initializeBarberSchedules(
                          userController.userAuth.uid);
                      routeController.softPush(AppRoutes.HOME);
                    }),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
