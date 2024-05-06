import 'package:flutter/cupertino.dart';
import 'package:lddm_puc_barberapp/Controllers/UserController.dart';
import 'package:lddm_puc_barberapp/services/UserService.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Common/Util.dart';
import '../../Controllers/RouteController.dart';
import '../../Controllers/login/LoginController.dart';
import '../../Routes/AppRoutes.dart';
import '../Common/RoundedButton.dart';

class LoginFormButton extends StatefulWidget {
  const LoginFormButton({super.key});

  @override
  State<LoginFormButton> createState() => _LoginFormButtonState();
}

class _LoginFormButtonState extends State<LoginFormButton> {
  late LoginController loginController;
  late RouteController routeController;
  late UserController userController;
  bool isLoading = false;
  UserService userService = UserService();

  @override
  void initState() {
    super.initState();

    loginController = context.read<LoginController>();
    routeController = context.read<RouteController>();
    userController = context.read<UserController>();
  }

  bool isFormValid() {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(loginController
                .loginWithEmailTextControllers['email']?.value.text ??
            "");

    return emailValid &&
        (loginController.loginWithEmailTextControllers['password']?.value
                        .text ??
                    "")
                .length >=
            1;
  }

  void passwordWrong() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Util.getWidth(0.78),
      height: Util.getHeight(0.065),
      child: RoundedButton(
        text: 'Entrar',
        isLoading: isLoading,
        isDisabled: !isFormValid(),
        isDisabledText: "Entrar",
        callBackOnPressed: () async {
          setState(() {
            isLoading = true;
          });

          final userLogin = {
            "email": loginController
                .loginWithEmailTextControllers['email']!.value.text,
            "password": loginController
                .loginWithEmailTextControllers['password']!.value.text
          };
          final loggedUser = await userService.login(userLogin);

          if (loggedUser == null) {
            //PARA E MOSTRA ERRO
            loginController.setShowPasswordError(true);
            return;
          }

          final SharedPreferences sharedMemory =
              await SharedPreferences.getInstance();
          sharedMemory.setInt('userId', loggedUser.id);
          userController.initializeUser(loggedUser);
          routeController.softPush(AppRoutes.HOMELOADING);

          setState(() {
            isLoading = false;
          });
        },
      ),
    );
  }
}
