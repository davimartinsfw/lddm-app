import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Controllers/NavBarController.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Controllers/ScheduleController.dart';
import 'package:lddm_puc_barberapp/Controllers/UserController.dart';
import 'package:lddm_puc_barberapp/Models/Procedure/Barber.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:lddm_puc_barberapp/SqLite/SQLHelper.dart';
import 'package:lddm_puc_barberapp/services/ProcedureService.dart';
import 'package:lddm_puc_barberapp/services/UserService.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/Procedure/Procedure.dart';
import '../Models/User/User.dart';
import '../initializers/AppWidget.dart';

class HomeLoading extends StatefulWidget {
  const HomeLoading({super.key});

  @override
  State<HomeLoading> createState() => _HomeLoadingState();
}

class _HomeLoadingState extends State<HomeLoading> {
  late RouteController routeController;
  late NavBarController navBarController;
  late UserController userController;
  late ScheduleController scheduleController;
  UserService userService = UserService();
  ProcedureService procedureService = ProcedureService();

  @override
  void initState() {
    super.initState();

    globalContext = context;
    routeController = context.read<RouteController>();
    navBarController = context.read<NavBarController>();
    routeController.initialize(navBarController);
    userController = context.read<UserController>();
    scheduleController = context.read<ScheduleController>();
    initialize();
  }

  void initialize() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int? id = sharedPreferences.getInt('userId');
      String? lastLoad = sharedPreferences.getString('lastUserLoad');
      SQLHelper.db();

      if (id == null) {
        throw Error();
      }

      late User? loadedUser;
      UserService userService = UserService();

      if (lastLoad == null ||
          DateTime.now().difference(DateTime.parse(lastLoad)).inHours > 24) {
        loadedUser = await userService.getUser(id);
        sharedPreferences.setString('lastUserLoad', DateTime.now().toString());
        SQLHelper.adicionarProduto(
            id,
            loadedUser!.name,
            loadedUser.email,
            loadedUser.cellphone,
            loadedUser.birthDate ?? '',
            loadedUser.isAdmin ?? false,
            loadedUser.isBarber ?? false,
            loadedUser.isClube ?? false);
      } else {
        final data = await SQLHelper.pegaUser();
        loadedUser = User.fromJson(data[0]);
      }

      if (loadedUser == null) {
        throw Error();
      }

      await initializeBarberList();
      await initializeProcedureList();
      userController.initializeUser(loadedUser);
      await userController.initializeUserSchedule();

      routeController.softPush(AppRoutes.HOME);
    } on Exception catch (e) {
      routeController.softPush(AppRoutes.LOGIN);
    }
  }

  Future<void> initializeBarberList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? lastBarberListUpdate =
        sharedPreferences.getString('lastBarberRender');

    if (lastBarberListUpdate == null ||
        DateTime.now()
                .difference(DateTime.parse(lastBarberListUpdate))
                .inHours >
            24) {
      List<Barber> barbersList = await userService.getBarbers();

      scheduleController.initializeBarberList(barbersList);
      sharedPreferences.setString(
          "lastBarberRender", DateTime.now().toString());

      List<String> encodedList = [];
      barbersList.forEach((element) {
        encodedList.add(jsonEncode(element.toJson()));
      });
      sharedPreferences.setStringList('barberList', encodedList);
    } else {
      List<String>? list = sharedPreferences.getStringList("barberList");
      List<Barber> barberList =
          List.from(list!.map((e) => Barber.fromJson(jsonDecode(e))));

      scheduleController.initializeBarberList(barberList);
    }
  }

  Future<void> initializeProcedureList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? lastProcedureListUpdate =
        sharedPreferences.getString('lastProcedureRender');

    if (lastProcedureListUpdate == null ||
        DateTime.now()
                .difference(DateTime.parse(lastProcedureListUpdate))
                .inHours >
            24) {
      List<Procedure> procedureList = await procedureService.getProcedure();

      scheduleController.initializeProcedureList(procedureList);
      sharedPreferences.setString(
          "lastProcedureRender", DateTime.now().toString());

      List<String> encodedList = [];
      procedureList.forEach((element) {
        encodedList.add(jsonEncode(element.toJson()));
      });
      sharedPreferences.setStringList('procedureList', encodedList);
    } else {
      List<String>? list = sharedPreferences.getStringList("procedureList");
      List<Procedure> procedureList =
          List.from(list!.map((e) => Procedure.fromJson(jsonDecode(e))));

      scheduleController.initializeProcedureList(procedureList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
