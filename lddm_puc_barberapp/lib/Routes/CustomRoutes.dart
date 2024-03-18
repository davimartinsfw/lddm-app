import 'package:lddm_puc_barberapp/View/HomePage.dart';
import 'package:lddm_puc_barberapp/View/ProcedureListView.dart';
import 'package:lddm_puc_barberapp/View/ProfilePage.dart';
import 'AppRoutes.dart';
import '../Models/Routes/CustomRoute.dart';

class CustomRoutes {
  final Map<String, CustomRoute> routes = {
    AppRoutes.HOME: CustomRoute(render: (_) => MyHomePage()),
    AppRoutes.PROFILE: CustomRoute(render: (_) => ProfilePage()),
    AppRoutes.PROCEDURELIST: CustomRoute(render: (_) => ProcedureListView()),
  };
}
