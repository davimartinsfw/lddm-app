import 'package:lddm_puc_barberapp/Controllers/NavBarController.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:provider/provider.dart';

final List<ChangeNotifierProvider> ChangeNotifierProviders = [
  ChangeNotifierProvider<NavBarController>(create: (_) => NavBarController()),
  ChangeNotifierProvider<RouteController>(create: (_) => RouteController())
];
