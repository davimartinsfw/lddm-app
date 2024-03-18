import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';

import '../Models/NavBar/NavBarItem.dart';

final List<NavBarItem> MOCK_NAV_BAR = [
  NavBarItem(name: "home", image: "assets/img/home-icon.svg", routeRedirect: AppRoutes.HOME),
  NavBarItem(name: "agendar", image: "assets/img/agendar-icon.svg", routeRedirect: AppRoutes.HOME),
  NavBarItem(name: "profile", image: "assets/img/profile-icon.svg", routeRedirect: AppRoutes.PROFILE),
];
