import 'package:flutter/material.dart';
import '../Models/Routes/CustomRoute.dart';
import '../Models/Routes/RouteHistory.dart';
import '../Routes/AppRoutes.dart';
import '../initializers/AppWidget.dart';
import 'NavBarController.dart';
import '../Routes/CustomRoutes.dart';

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class RouteController extends ChangeNotifier {
  CustomRoutes _customRoutes = CustomRoutes();
  bool loadingRequest = false;
  late NavBarController navbarController;
  late Widget _page;
  bool _routeCallbackCalled = false;
  List<RouteHistory> _routeHistory = [];
  AnimationController? hideScreenController;
  AnimationController? showScreenController;
  bool _showing = true;

  get showing => _showing;

  get page => _page;

  get routeCallbackCalled => _routeCallbackCalled;

  get routeHistory => _routeHistory;

  void initialize(NavBarController navController) {
    navbarController = navController;
  }

  String? popHistory() {
    String route = _routeHistory.last.path;
    _routeHistory.removeLast();

    return route;
  }

  void pushHistory(String route, [dynamic arguments]) {
    _routeHistory.add(RouteHistory(route, arguments));
  }

  void _redirectWithoutAnimation() {
    Navigator.push(globalContext, PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => _page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ));
  }

  void setLoadingFalse() {
    loadingRequest = false;
    notifyListeners();
  }

  void setLoadingTrue() {
    loadingRequest = true;
    notifyListeners();
  }

  void setCurrentPage(Widget page) {
    _page = page;
  }

  void setRouteCallbackCalled(bool value) {
    _routeCallbackCalled = value;
  }

  void softPop([bool? shouldIgnoreNavbarUpdate]) {
    popHistory();

    final route = _routeHistory.last;

    if (_routeHistory.length == 0) {
      _softSetRoute(AppRoutes.HOME, null, false, true);

      _redirectWithoutAnimation();

      return;
    }

    _softSetRoute(route.path, route.arguments, shouldIgnoreNavbarUpdate, true);

    _redirectWithoutAnimation();
  }

  void softPush(String routePath,
      [dynamic arguments]) async {
    _softSetRoute(routePath, arguments);
    pushHistory(routePath, arguments);

    _redirectWithoutAnimation();
  }

  void _softSetRoute(String routePath,
      [dynamic arguments, bool? shouldIgnoreNavbarUpdate, bool? isPop]) {
    CustomRoute? route = _customRoutes.routes[routePath];

    if (route == null && isPop != null && isPop) {
      route = _customRoutes.routes['AppRoutes.HOME'];
      routePath = 'AppRoutes.HOME';
    }

    _page = route?.render(arguments) ?? Container();

    if (shouldIgnoreNavbarUpdate != null && shouldIgnoreNavbarUpdate == true) {
      return;
    }

    navbarController.updateOnRouteChange(routePath);
  }
}
