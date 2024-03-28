import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/RouteController.dart';
import '../initializers/AppWidget.dart';
import '../initializers/DevelopmentRecognizer.dart';

class CustomRouteObserver extends StatefulWidget {
  String name;
  Widget widget;

  CustomRouteObserver({Key? key, required this.name, required this.widget})
      : super(key: key);

  @override
  State<CustomRouteObserver> createState() => _CustomRouteObserverState();
}

class _CustomRouteObserverState extends State<CustomRouteObserver>
    with RouteAware, WidgetsBindingObserver {
  // late CourseListController courseListController;
  // late LoginController loginController;
  // late OpenAdController openAdController;
  late RouteController routeController;
  // late UserController userController;
  bool hasCalled = false;
  late StreamSubscription<FGBGType> subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // courseListController = context.read<CourseListController>();
    // loginController = context.read<LoginController>();
    // openAdController = context.read<OpenAdController>();
    routeController = context.read<RouteController>();
    // userController = context.read<UserController>();
    routeController.setCurrentPage(widget.widget);
    globalContext = context;

    subscription = FGBGEvents.stream.listen((event) {
      if (event == FGBGType.foreground) {
        callbackForeground();

        return;
      }

      callbackBackground();
    });
  }

  void callbackBackground() async {
    // if (!openAdController.isAdAvailable) {
    //   final sharedMemory = await SharedPreferences.getInstance();
    //   int? numberOfOpen = sharedMemory.getInt("openAppCounter") ?? 0;
    //   openAdController.loadAd(numberOfOpen);
    // }
  }

  void callbackForeground() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // final bool callLogin =
    //     sharedPreferences.getString(loginController.sharedKey) == 'awaiting';

    // if (callLogin) {
    //   return;
    // }

    //openAdController.showAdIfAvailable(routeController);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    subscription.cancel();

    super.dispose();
  }

  void onPop(bool value) {
    if (routeController.routeHistory.length > 0) {
      routeController.softPop();

      //return Future.value(false);
    }

    routeController.popHistory();

    //return Future.value(true);
  }

  Widget renderPage(BuildContext context) {
    // if (routeController.loadingRequest) {
    //   return EmailLoading();
    // }

    return routeController.page;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<RouteController>();

    return PopScope(
      child: Stack(children: [renderPage(context), DevelopmentRecognizer()]),
      onPopInvoked: onPop,
    );
  }
}
