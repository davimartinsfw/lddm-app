import 'package:lddm_puc_barberapp/Controllers/ButtonReturnController.dart';
import 'package:lddm_puc_barberapp/Controllers/EditProfileController.dart';
import 'package:lddm_puc_barberapp/Controllers/NavBarController.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Controllers/ScheduleController.dart';
import 'package:lddm_puc_barberapp/Controllers/UserController.dart';
import 'package:lddm_puc_barberapp/Controllers/login/LoginController.dart';
import 'package:provider/provider.dart';

final List<ChangeNotifierProvider> ChangeNotifierProviders = [
  ChangeNotifierProvider<NavBarController>(create: (_) => NavBarController()),
  ChangeNotifierProvider<RouteController>(create: (_) => RouteController()),
  ChangeNotifierProvider<LoginController>(create: (_) => LoginController()),
  ChangeNotifierProvider<UserController>(create: (_) => UserController()),
  ChangeNotifierProvider<ButtonReturnController>(
      create: (_) => ButtonReturnController()),
  ChangeNotifierProvider<ScheduleController>(
      create: (_) => ScheduleController()),
  ChangeNotifierProvider<EditProfileController>(
      create: (_) => EditProfileController())
];
