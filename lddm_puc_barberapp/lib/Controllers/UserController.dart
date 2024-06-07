import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lddm_puc_barberapp/services/ScheduleService.dart';
import 'package:lddm_puc_barberapp/services/UserService.dart';

import '../Models/Schedule/Schedule.dart';

class UserController extends ChangeNotifier {
  late var userProfile;
  late var userAuth = null;
  late List<Schedule> userSchedule;
  ScheduleService scheduleService = ScheduleService();
  UserService userService = UserService();

  Future<void> initializeUser(User? user) async {
    userAuth = user;
    userProfile = await FirebaseFirestore.instance
        .collection("usuario")
        .doc(userAuth!.uid)
        .get();
  }

  Future<void> createUser(user) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user["email"], password: user["password"]);
    userAuth = FirebaseAuth.instance.currentUser;
    if (userAuth != null) {
      await FirebaseFirestore.instance
          .collection("usuario")
          .doc(userAuth.uid)
          .set({
        "email": user["email"],
        "password": user["password"],
        "phone": user["phone"],
        "name": user["name"],
      });
      userProfile = await FirebaseFirestore.instance
          .collection("usuario")
          .doc(userAuth!.uid)
          .get();
    }
  }

  Future<void> login(email, password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    userAuth = FirebaseAuth.instance.currentUser;
    if (userAuth != null) {
      userProfile = await FirebaseFirestore.instance
          .collection("usuario")
          .doc(userAuth!.uid)
          .get();
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    userAuth = null;
    userProfile = null;
  }

  Future<void> updateUser(changes) async {
    await FirebaseFirestore.instance
        .collection("usuario")
        .doc(userAuth.uid)
        .set(changes);

    userProfile = await FirebaseFirestore.instance
        .collection("usuario")
        .doc(userAuth.uid)
        .get();
  }

  getBarbers() {
    return FirebaseFirestore.instance
        .collection("usuario")
        .where("is_barber", isEqualTo: true);
  }

  Future<void> initializeUserSchedule() async {
    userSchedule = await scheduleService.getUserSchedule(userProfile.id);
  }

  Future<void> deleteUser() async {
    await FirebaseFirestore.instance
        .collection("usuario")
        .doc(userAuth.uid)
        .delete();
    await userAuth!.delete();
  }

  Future<void> reloadUser() async {
    var u = await userService.getUser(userProfile.id);
    if (u != null) {
      userProfile = u;
      notifyListeners();
    }
  }
}
