import 'package:lddm_puc_barberapp/Controllers/NavBarController.dart';
import 'package:provider/provider.dart';

final List<ChangeNotifierProvider> ChangeNotifierProviders = [
  ChangeNotifierProvider<NavBarController>(create: (_) => NavBarController())
];
