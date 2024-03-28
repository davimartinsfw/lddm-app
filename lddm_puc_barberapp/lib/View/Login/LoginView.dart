import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lddm_puc_barberapp/initializers/AppWidget.dart';
import 'package:provider/provider.dart';
import '../../../Common/Util.dart';
import '../../../Routes/AppRoutes.dart';
import '../../Components/Common/RoundedButton.dart';
import '../../Controllers/NavBarController.dart';
import '../../Controllers/RouteController.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late RouteController routeController;
  late NavBarController navBarController;

  @override
  void initState() {
    super.initState();

    globalContext = context;
    routeController = context.read<RouteController>();
    navBarController = context.read<NavBarController>();
    routeController.initialize(navBarController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            Container(
              height: Util.getHeight(0.73),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: SvgPicture.asset(
                      'assets/img/nordus-logo.svg',
                      width: Util.getWidth(0.6),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: Util.getHeight(0.015))),
                ],
              ),
            ),
            Container(
              height: Util.getHeight(0.27),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Util.getWidth(0.78),
                        height: Util.getHeight(0.065),
                        child: RoundedButton(
                          text: 'Começar',
                          callBackOnPressed: () {
                            routeController
                                .softPush(AppRoutes.CREATEACCOUNTFORM);
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: Util.getHeight(0.035))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Util.getWidth(0.78),
                        height: Util.getHeight(0.065),
                        child: RoundedButton(
                          color: Colors.transparent,
                          borderColor: Util.TextColor,
                          borderWidth: 1.2,
                          borderStyle: BorderStyle.solid,
                          elevation: 0,
                          text: 'Já tenho conta',
                          callBackOnPressed: () {
                            routeController.softPush(AppRoutes.LOGINFORM);
                          },
                          textColor: Util.TextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
