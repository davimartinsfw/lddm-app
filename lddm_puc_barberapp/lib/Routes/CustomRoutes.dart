import 'package:lddm_puc_barberapp/View/AboutUsView.dart';
import 'package:lddm_puc_barberapp/View/HomeLoading.dart';
import 'package:lddm_puc_barberapp/View/HomePage.dart';
import 'package:lddm_puc_barberapp/View/Login/CreateAccountFormView.dart';
import 'package:lddm_puc_barberapp/View/Login/LoginFormView.dart';
import 'package:lddm_puc_barberapp/View/Login/LoginView.dart';
import 'package:lddm_puc_barberapp/View/ProcedureListView.dart';
import 'package:lddm_puc_barberapp/View/ProfilePage.dart';
import 'package:lddm_puc_barberapp/View/ConfirmScheduleView.dart';
import 'package:lddm_puc_barberapp/View/ScheduleFinishedView.dart';
import 'AppRoutes.dart';
import '../Models/Routes/CustomRoute.dart';

class CustomRoutes {
  final Map<String, CustomRoute> routes = {
    AppRoutes.HOME: CustomRoute(render: (_) => MyHomePage()),
    AppRoutes.HOMELOADING: CustomRoute(render: (_) => HomeLoading()),
    AppRoutes.ABOUTUS: CustomRoute(render: (_) => AboutUsView()),
    AppRoutes.PROFILE: CustomRoute(render: (_) => ProfilePage()),
    AppRoutes.PROCEDURELIST: CustomRoute(render: (_) => ProcedureListView()),
    AppRoutes.LOGIN: CustomRoute(render: (_) => LoginView()),
    AppRoutes.LOGINFORM: CustomRoute(render: (_) => LoginFormView()),
    AppRoutes.CREATEACCOUNTFORM:
        CustomRoute(render: (_) => CreateAccountFormView()),
    AppRoutes.SCHEDULEFINISHED:
        CustomRoute(render: (_) => ScheduleFinishedView()),
    AppRoutes.CONFIRMSCHEDULE:
        CustomRoute(render: (_) => ConfirmScheduleView()),
  };
}
