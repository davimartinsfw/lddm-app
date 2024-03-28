import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Common/Util.dart';
import '../../Components/Login/CreateAccountButton.dart';
import '../../Components/Login/CreateAccountFormFields.dart';
import '../../Components/Login/CreateAccountTerms.dart';
import '../../Components/Login/LoginFormHeader.dart';
import '../../Controllers/ButtonReturnController.dart';
import '../../Controllers/login/LoginController.dart';

class CreateAccountFormView extends StatefulWidget {
  const CreateAccountFormView({super.key});

  @override
  State<CreateAccountFormView> createState() => _CreateAccountFormViewState();
}

class _CreateAccountFormViewState extends State<CreateAccountFormView> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    LoginFormHeader(
                        title: "Crie sua conta",
                        desc: "Preencha seus dados para continuar"),
                    CreateAccountFormFields(),
                  ],
                ),
                Column(
                  children: [CreateAccountButton(), CreateAccountTerms()],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
