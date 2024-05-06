import 'package:flutter/cupertino.dart';
import 'package:lddm_puc_barberapp/services/ScheduleService.dart';
import 'package:lddm_puc_barberapp/services/UserService.dart';

import '../Models/Schedule/Schedule.dart';
import '../Models/User/User.dart';

class UserController extends ChangeNotifier {
  late User userProfile;
  late List<Schedule> userSchedule;
  ScheduleService scheduleService = ScheduleService();
  UserService userService = UserService();

  void initializeUser(User user) {
    userProfile = user;
  }

  Future<void> initializeUserSchedule() async {
    userSchedule = await scheduleService.getUserSchedule(userProfile.id);
  }

  void deleteUser() {
    userService.deleteUser(userProfile.id);
  }

  Future<void> reloadUser() async {
    User? u = await userService.getUser(userProfile.id);
    if (u != null) {
      userProfile = u;
      notifyListeners();
    }
  }

  Future<void> updateUser(Map<String, dynamic> user) async {
    await userService.updateUser(userProfile.id, user);
  }
}
