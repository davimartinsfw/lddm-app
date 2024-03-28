import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Common/Util.dart';
import '../../Components/Login/LoginFormButton.dart';
import '../../Components/Login/LoginFormFields.dart';
import '../../Components/Login/LoginFormHeader.dart';
import '../../Controllers/ButtonReturnController.dart';
import '../../Controllers/login/LoginController.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView({super.key});

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  @override
  Widget build(BuildContext context) {
    context.watch<LoginController>();
    context.watch<ButtonReturnController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: Util.getHeight(0.92),
            child: Column(
              children: [
                Column(
                  children: [
                    LoginFormHeader(
                        title: "Bem-vindo(a) de volta!",
                        desc: "Preencha seus dados para continuar"),
                    LoginFormFields(),
                    LoginFormButton()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
