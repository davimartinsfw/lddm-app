import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controllers/RouteController.dart';
import 'CustomRouteObserver.dart';
import 'CustomRoutes.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final customRoutes = CustomRoutes();
    final route = customRoutes.routes[settings.name];
    final Widget page = route?.render(settings.arguments) ?? Scaffold(body: Placeholder(),);
    return routeTo(settings.name!, page);
  }

  static Route<dynamic> routeTo(String route, Widget page) {
    return MaterialPageRoute(builder: (context) {
      RouteController routeController = context.read<RouteController>();
      routeController.pushHistory(route);

      return CustomRouteObserver(name: route, widget: page);
    });
  }
}
