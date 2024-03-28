import 'package:flutter/cupertino.dart';

class ScheduleController extends ChangeNotifier {
  bool shouldShowProcedure = false;
  bool shouldShowProfessional = false;
  bool shouldShowCalendar = false;

  String? professional = null;
  String? procedure = null;
  DateTime? time = null;


  void disposeSchedule() {
    professional = null;
    procedure = null;
    time = null;
    shouldShowProcedure = false;
    shouldShowProfessional = false;
    shouldShowCalendar = false;
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

  void updateProfessional(String name) {
    professional = name;
    notifyListeners();
  }

  void updateProcedure(String name) {
    procedure = name;
    notifyListeners();
  }

  void updateTime(DateTime newTime) {
    time = newTime;
    //notifyListeners();
  }
}