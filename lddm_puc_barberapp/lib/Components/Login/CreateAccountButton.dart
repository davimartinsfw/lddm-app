import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/services/UserService.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Common/Util.dart';
import '../../../../Routes/AppRoutes.dart';
import '../../Controllers/ButtonReturnController.dart';
import '../../Controllers/RouteController.dart';
import '../../Controllers/login/LoginController.dart';
import '../../Models/User/User.dart';
import '../Common/RoundedButton.dart';
import '../../Controllers/UserController.dart';

class CreateAccountButton extends StatefulWidget {
  const CreateAccountButton({Key? key}) : super(key: key);

  @override
  State<CreateAccountButton> createState() => _CreateAccountButtonState();
}

class _CreateAccountButtonState extends State<CreateAccountButton> {
  late LoginController loginController;
  late ButtonReturnController buttonReturnController;
  late RouteController routeController;
  late UserController userController;
  bool isLoading = false;
  UserService userService = UserService();

  @override
  void initState() {
    super.initState();

    loginController = context.read<LoginController>();
    buttonReturnController = context.read<ButtonReturnController>();
    routeController = context.read<RouteController>();
    userController = context.read<UserController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Util.getWidth(0.78),
      height: Util.getHeight(0.065),
      child: RoundedButton(
        text: 'Cadastrar',
        isDisabled: !loginController.isCreateAccountFormValid(),
        isDisabledText: "Cadastrar",
        isLoading: isLoading,
        callBackOnPressed: () async {
          setState(() {
            isLoading = true;
          });
          userController.createUser({
            "email": loginController
                .loginWithEmailTextControllers['email']!.value.text,
            "password": loginController
                .loginWithEmailTextControllers['password']!.value.text,
            "phone": loginController
                .loginWithEmailTextControllers['phone']!.value.text,
            "name": loginController
                .loginWithEmailTextControllers['name']!.value.text,
          });

          // final userEncoded = {
          //   "name": loginController
          //       .loginWithEmailTextControllers['name']!.value.text,
          //   "email": loginController
          //       .loginWithEmailTextControllers['email']!.value.text,
          //   "phone_number": loginController
          //       .loginWithEmailTextControllers['phone']!.value.text
          //       .replaceAll("(", "")
          //       .replaceAll(")", "")
          //       .replaceAll("-", "")
          //       .replaceAll(" ", "")
          //       .trim(),
          //   "password": loginController
          //       .loginWithEmailTextControllers['password']!.value.text,
          // };
          //
          // final User? user = await userService.postUser(userEncoded);
          //
          // if (user == null) {
          //   //MOSTRA ERRO NA TELA
          //   return;
          // }

          setState(() {
            isLoading = false;
          });

          // final SharedPreferences sharedMemory =
          //     await SharedPreferences.getInstance();
          // sharedMemory.setInt('userId', user.id);
          routeController.softPush(AppRoutes.HOMELOADING);
        },
      ),
    );
  }
}
