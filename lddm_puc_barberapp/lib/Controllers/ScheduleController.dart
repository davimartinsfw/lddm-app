import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lddm_puc_barberapp/Models/Schedule/Schedule.dart';
import 'package:lddm_puc_barberapp/services/ScheduleService.dart';
import '../Models/Procedure/Barber.dart';
import '../Models/Procedure/Procedure.dart';

class ScheduleController extends ChangeNotifier {
  late List<Barber> barberList;
  late List<Procedure> procedureList;
  List<Schedule> barberSchedules = [];
  File? actualPhoto = null;
  File? actualImage = null;
  ImagePicker picker = ImagePicker();
  DateTime focusedDate = DateTime.now();
  late Schedule actualSchedule = Schedule(
      id: '', userId: null, barberId: null, procedureId: null, horario: null);
  late ScheduleService scheduleService = ScheduleService();

  bool shouldShowProcedure = false;
  bool shouldShowProfessional = false;
  bool shouldShowCalendar = false;

  void resetSchedule() {
    actualSchedule = Schedule(
        id: '', userId: null, barberId: null, procedureId: null, horario: null);
    focusedDate = DateTime.now();
    actualPhoto = null;
    actualImage = null;
  }

  void setActualPhoto(File? file) {
    actualPhoto = file;

    notifyListeners();
  }

  void setActualImage(File? file) {
    actualImage = file;

    notifyListeners();
  }

  Future<void> initializeBarberList() async {
    List<Barber> list = [];

    await FirebaseFirestore.instance
        .collection("usuario")
        .where("is_barber", isEqualTo: true)
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          Map<String, dynamic> map = docSnapshot.data();
          map['id'] = docSnapshot.id;
          list.add(Barber.fromJson(map));
        }
      },
      onError: (e) => print("Erro ao buscar barbeiros: $e"),
    );

    barberList = list;
  }

  Future<void> initializeProcedureList() async {
    List<Procedure> list = [];

    await FirebaseFirestore.instance.collection("procedure").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Map<String, dynamic> map = docSnapshot.data();
          map['id'] = docSnapshot.id;
          list.add(Procedure.fromJson(map));
        }
      },
      onError: (e) => print("Erro ao buscar procedimentos: $e"),
    );

    procedureList = list;
  }

  Future<void> initializeBarberSchedules(String barberId) async {
    final barberRef =
        FirebaseFirestore.instance.collection('usuario').doc(barberId);

    List<Schedule> list = [];

    await FirebaseFirestore.instance
        .collection("schedule")
        .where("barber_id", isEqualTo: barberRef)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Map<String, dynamic> map = docSnapshot.data();
          map['id'] = docSnapshot.id;
          list.add(Schedule.fromJson(map));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    barberSchedules = list; //await scheduleService.getBarberSchedule(barberId);
    notifyListeners();
  }

  void updateFocusedDay(DateTime newDate) {
    focusedDate = newDate;
    notifyListeners();
  }

  void updateProcedureShow(bool value) {
    shouldShowProcedure = value;
    notifyListeners();
  }

  void updateProfessionalShow(bool value) {
    shouldShowProfessional = value;
    notifyListeners();
  }

  void updateCalendarShow(bool value) {
    shouldShowCalendar = value;
    notifyListeners();
  }

  void updateProfessional(String id) async {
    final barberRef = FirebaseFirestore.instance.collection('usuario').doc(id);

    actualSchedule.barberId = barberRef;
    notifyListeners();
  }

  void updateProcedure(String id) {
    final procedureRef =
        FirebaseFirestore.instance.collection('procedure').doc(id);

    actualSchedule.procedureId = procedureRef;
    notifyListeners();
  }

  void updateTime(DateTime newTime) {
    actualSchedule.horario = newTime;
    //notifyListeners();
  }
}
