import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lddm_puc_barberapp/Common/MonthsInPortuguese.dart';
import 'package:lddm_puc_barberapp/Components/Common/RoundedButton.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Controllers/UserController.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:lddm_puc_barberapp/services/ScheduleService.dart';
import 'package:provider/provider.dart';
import '../Common/NavBar.dart';
import '../Common/PageHeader.dart';
import '../Common/Util.dart';
import '../Controllers/ScheduleController.dart';
import 'PreviewPage.dart';

class ConfirmScheduleView extends StatefulWidget {
  const ConfirmScheduleView({super.key});

  @override
  State<ConfirmScheduleView> createState() => _ConfirmScheduleViewState();
}

class _ConfirmScheduleViewState extends State<ConfirmScheduleView> {
  late ScheduleController scheduleController;
  late RouteController routeController;
  late UserController userController;
  ScheduleService scheduleService = ScheduleService();
  final ImagePicker _picker = ImagePicker();
  bool buttonLoading = false;

  @override
  void initState() {
    super.initState();

    scheduleController = context.read<ScheduleController>();
    routeController = context.read<RouteController>();
    userController = context.read<UserController>();
  }

  Future getFileFromGallery() async {
    XFile? image =
        await scheduleController.picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      scheduleController.setActualImage(File(image.path));
    }
  }

  Widget renderImageSelector(bool b, Function callback) {
    if (b) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: Util.SecondaryColor)),
        padding: EdgeInsets.all(50),
        width: Util.getWidth(0.9),
        child: Center(
          child: Image.asset('assets/img/check-circle.png'),
        ),
      );
    }

    return DottedBorder(
      borderType: BorderType.RRect,
      strokeWidth: 2,
      dashPattern: [6],
      color: Util.SecondaryColor,
      radius: Radius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            callback.call();
          },
          child: Container(
            padding: EdgeInsets.all(50),
            width: Util.getWidth(0.9),
            child: Center(
              child: Image.asset('assets/img/image-placeholder.png'),
            ),
          ),
        ),
      ),
    );
  }

  Widget renderScheduleBox() {
    if (scheduleController.actualSchedule.procedureId == null ||
        scheduleController.actualSchedule.barberId == null ||
        scheduleController.actualSchedule.horario == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
            color: Util.PrimaryColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: Util.getBoxShadow()),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(24),
              padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
              decoration: BoxDecoration(
                  color: Util.SecondaryColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: Util.getBoxShadow()),
              child: Center(
                child: Column(
                  children: [
                    Text(
                        scheduleController.actualSchedule.horario!.day
                            .toString(),
                        style: Util.fontStyleSB(20, Util.PrimaryColor)),
                    Text(
                        MonthsInPortuguese().witchDay(
                            scheduleController.actualSchedule.horario!.weekday),
                        style: Util.fontStyleSB(16, Util.PrimaryColor)),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Serviço: ',
                      style: Util.fontStyle(),
                    ),
                    Text(
                      scheduleController.procedureList
                          .firstWhere((element) =>
                              element.id ==
                              scheduleController.actualSchedule.procedureId?.id)
                          .name,
                      style: Util.fontStyleSB(),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 6)),
                Row(
                  children: [
                    Text(
                      'Profissional: ',
                      style: Util.fontStyle(),
                    ),
                    Text(
                      scheduleController.barberList
                          .firstWhere((element) =>
                              element.id ==
                              scheduleController.actualSchedule.barberId?.id)
                          .name,
                      style: Util.fontStyleSB(),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 6)),
                Row(
                  children: [
                    Text('Dia ', style: Util.fontStyle()),
                    Text(
                      "${scheduleController.actualSchedule.horario!.day.toString()} de ${MonthsInPortuguese().witchMonth(scheduleController.actualSchedule.horario!.month)}",
                      style: Util.fontStyleSB(15, Util.SecondaryColor),
                    ),
                    Text(' às ', style: Util.fontStyle()),
                    Text(
                      "${add0(scheduleController.actualSchedule.horario!.hour)}:${add0(scheduleController.actualSchedule.horario!.minute)}",
                      style: Util.fontStyleSB(15, Util.SecondaryColor),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String add0(int i) {
    return i < 10 ? '0$i' : i.toString();
  }

  void onFile(File file) async {
    scheduleController.setActualPhoto(file);
    routeController.softPush(AppRoutes.PREVIEWPAGE, file);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ScheduleController>();

    return Scaffold(
      appBar: PageHeader("Confirmar agendamento", routeController),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 0, top: 20, left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Confirme as informações:",
                        style: Util.fontStyleSB(20)),
                  ],
                )),
            renderScheduleBox(),
            Padding(
                padding: EdgeInsets.only(bottom: 12, top: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Envie uma foto do seu cabelo atual:",
                            style: Util.fontStyleSB(16)),
                        Text("(opcional)",
                            style: Util.fontStyle(10, Util.HeaderArrow)),
                      ],
                    ),
                  ],
                )),
            renderImageSelector(scheduleController.actualPhoto != null, () {
              routeController.softPush(AppRoutes.CAMERA, onFile);
            }),
            Padding(
                padding: EdgeInsets.only(bottom: 12, top: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: Util.getWidth(0.9),
                            child: Text(
                                "Agora uma imagem do corte que quer de referência:",
                                style: Util.fontStyleSB(16))),
                        Text("(opcional)",
                            style: Util.fontStyle(10, Util.HeaderArrow)),
                      ],
                    ),
                  ],
                )),
            renderImageSelector(
                scheduleController.actualImage != null, getFileFromGallery),
            Container(
                margin: EdgeInsets.only(top: 24, bottom: 32),
                width: Util.getWidth(0.62),
                child: RoundedButton(
                    isLoading: buttonLoading,
                    text: 'Confirmar agendamento',
                    callBackOnPressed: () async {
                      setState(() {
                        buttonLoading = true;
                      });

                      if (scheduleController.actualImage != null &&
                          scheduleController.actualPhoto != null) {
                        final storage = FirebaseStorage.instance;
                        final String dateTime =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        final String imageRef =
                            "images/reference/$dateTime.png";
                        final String photoRef = "images/photo/$dateTime.jpg";
                        await storage
                            .ref(imageRef)
                            .putFile(scheduleController.actualImage!);
                        await storage
                            .ref(photoRef)
                            .putFile(scheduleController.actualPhoto!);
                        scheduleController.actualSchedule.fotoAtual =
                            await storage.ref(photoRef).getDownloadURL();
                        scheduleController.actualSchedule.fotoCorte =
                            await storage.ref(imageRef).getDownloadURL();
                      }

                      scheduleController.actualSchedule.userId =
                          FirebaseFirestore.instance
                              .collection('usuario')
                              .doc(userController.userAuth.uid);

                      await FirebaseFirestore.instance
                          .collection('schedule')
                          .doc()
                          .set(scheduleController.actualSchedule.toJson());

                      setState(() {
                        buttonLoading = false;
                      });

                      routeController.softPush(AppRoutes.SCHEDULEFINISHED);
                    }))
          ],
        ),
      )),
      bottomNavigationBar: NavBar(),
    );
  }
}
