import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Models/NavBar/NavBarItem.dart';
import 'package:lddm_puc_barberapp/data/NavBarItems.dart';

class NavBarController extends ChangeNotifier {
  final List<NavBarItem> list = MOCK_NAV_BAR;
  int actualIndex = 0;
  late RouteController routeController;

  void initialize(RouteController controller) {
    routeController = controller;
  }

  void changeIndex(int i) {
    routeController.softPush(list[i].routeRedirect);
    actualIndex = i;
    notifyListeners();
  }

  void updateOnRouteChange(String? route) {
    if (route == null) {
      return;
    }

    String baseRoute = route.split('/')[1].split('-')[0];

    list.forEach((element) {
      if (baseRoute == element.name) {
        actualIndex = list.indexOf(element);
        notifyListeners();
      }
    });
  }
}
