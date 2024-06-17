import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lddm_puc_barberapp/Models/User/User.dart';
import 'package:lddm_puc_barberapp/services/ScheduleService.dart';
import 'package:lddm_puc_barberapp/services/UserService.dart';

import '../Models/Schedule/Schedule.dart';

class UserController extends ChangeNotifier {
  late UserProfile? userProfile;
  late var userAuth = null;
  late List<Schedule> userSchedule;
  ScheduleService scheduleService = ScheduleService();
  UserService userService = UserService();

  Future<void> initializeUser(User? user) async {
    userAuth = user;
    final doc = await FirebaseFirestore.instance
        .collection("usuario")
        .doc(userAuth!.uid)
        .get();

    userProfile = UserProfile.fromJson(doc.data()!);
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
      final doc = await FirebaseFirestore.instance
          .collection("usuario")
          .doc(userAuth!.uid)
          .get();

      userProfile = UserProfile.fromJson(doc.data()!);
    }
  }

  Future<void> login(email, password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    userAuth = FirebaseAuth.instance.currentUser;
    if (userAuth != null) {
      final doc = await FirebaseFirestore.instance
          .collection("usuario")
          .doc(userAuth!.uid)
          .get();

      userProfile = UserProfile.fromJson(doc.data()!);
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

    final doc = await FirebaseFirestore.instance
        .collection("usuario")
        .doc(userAuth!.uid)
        .get();

    userProfile = UserProfile.fromJson(doc.data()!);
  }

  getBarbers() {
    return FirebaseFirestore.instance
        .collection("usuario")
        .where("is_barber", isEqualTo: true);
  }

  Future<void> initializeUserSchedule() async {
    List<Schedule> list = [];

    final userRef =
        FirebaseFirestore.instance.collection('usuario').doc(userAuth.uid);

    await FirebaseFirestore.instance
        .collection("schedule")
        .where("user_id", isEqualTo: userRef)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Map<String, dynamic> map = docSnapshot.data();
          map['id'] = docSnapshot.id;

          list.add(Schedule.fromJson(map));
        }
      },
      onError: (e) => print("Erro ao buscar agendamentos: $e"),
    );

    userSchedule = list;
  }

  Future<void> deleteUser() async {
    await FirebaseFirestore.instance
        .collection("usuario")
        .doc(userAuth.uid)
        .delete();
    await userAuth!.delete();
  }

  Future<void> reloadUser() async {
    var u = await userService.getUser(userAuth.uid);
    if (u != null) {
      userProfile = u;
      notifyListeners();
    }
  }
}
