import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lddm_puc_barberapp/Models/Schedule/Schedule.dart';
import 'package:lddm_puc_barberapp/services/ScheduleService.dart';
import '../Models/Procedure/Barber.dart';
import '../Models/Procedure/Procedure.dart';

class ScheduleController extends ChangeNotifier {
  late List<Barber> barberList;
  late List<Procedure> procedureList;
  List<Schedule> barberSchedules = [];
  DateTime focusedDate = DateTime.now();
  late Schedule actualSchedule =
      Schedule(userId: null, barberId: null, procedureId: null, horario: null);
  late ScheduleService scheduleService = ScheduleService();

  bool shouldShowProcedure = false;
  bool shouldShowProfessional = false;
  bool shouldShowCalendar = false;

  void resetSchedule() {
    actualSchedule = Schedule(
        userId: null, barberId: null, procedureId: null, horario: null);
    focusedDate = DateTime.now();
  }

  Future<void> initializeBarberList() async {
    final col = FirebaseFirestore.instance
        .collection("usuario");

    final query = await col.where("is_barber", isEqualTo: true).get();
    List<Barber> list = [];

    query.docs.forEach((doc) {
      list.add(Barber.fromJson(doc.data()));
    });

    barberList = list;
  }

  void initializeProcedureList(List<Procedure> list) {
    procedureList = list;
  }

  void initializeBarberSchedules(int barberId)  async{
    barberSchedules = await scheduleService.getBarberSchedule(barberId);
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

  void updateProfessional(int id) {
    actualSchedule.barberId = id;
    notifyListeners();
  }

  void updateProcedure(int id) {
    actualSchedule.procedureId = id;
    notifyListeners();
  }

  void updateTime(DateTime newTime) {
    actualSchedule.horario = newTime;
    //notifyListeners();
  }
}
