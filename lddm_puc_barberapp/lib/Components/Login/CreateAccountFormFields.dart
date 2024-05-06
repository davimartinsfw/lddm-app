import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../../../../Common/Util.dart';
import '../../Controllers/ButtonReturnController.dart';
import '../../Controllers/login/LoginController.dart';
import '../../Models/Profile/Field.dart';
import '../Common/CustomTextField.dart';

class CreateAccountFormFields extends StatefulWidget {
  const CreateAccountFormFields({super.key});

  @override
  State<CreateAccountFormFields> createState() =>
      _CreateAccountFormFieldsState();
}

class _CreateAccountFormFieldsState extends State<CreateAccountFormFields> {
  late LoginController loginController;
  late ButtonReturnController buttonReturnController;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final String passwordText =
      "A senha deve conter 8 ou mais caracteres, no mínimo 1 número, 1 ou mais letras maiúsculas.";

  @override
  void initState() {
    super.initState();

    loginController = context.read<LoginController>();
    buttonReturnController = context.read<ButtonReturnController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Util.getWidth(0.91),
          child: CustomTextField(
            controller:
                loginController.loginWithEmailTextControllers['name']!,
            field: Field(
                controller:
                    loginController.loginWithEmailTextControllers['name'],
                hintText: "Nome Completo",
                error: (TextEditingController controller) {
                  if (controller.value.text != "" &&
                      controller.value.text.length < 5) {
                    return "Insira seu nome completo";
                  }
                },
                label: 'Nome'),
            //callBack: buttonReturnController.updateButton,
            //shouldShowValidateButton: false
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Util.getWidth(0.91),
              child: CustomTextField(
                controller:
                    loginController.loginWithEmailTextControllers['email']!,
                field: Field(
                    error: (TextEditingController controller) {
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(controller.value.text);

                      if (!emailValid && controller.value.text != "") {
                        return "Email inválido";
                      }
                    },
                    hintText: "E-mail",
                    keyboardType: TextInputType.emailAddress,
                    controller:
                        loginController.loginWithEmailTextControllers['email'],
                    label: 'E-mail'),
                // callBack: buttonReturnController.updateButton,
                // shouldShowValidateButton: false,
                // autoCorrectActive: false,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(bottom: 16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Util.getWidth(0.91),
              child: CustomTextField(
                controller:
                loginController.loginWithEmailTextControllers['phone']!,
                field: Field(
                    // error: (TextEditingController controller) {
                    //   final bool emailValid = RegExp(r'[0-9]')
                    //       .hasMatch(controller.value.text) && controller.value.text.length;
                    //
                    //   if (!emailValid && controller.value.text != "") {
                    //     return "Celular inválido";
                    //   }
                    // },
                    formatters: [
                      MaskTextInputFormatter(
                          mask: '(##) #####-####',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy)
                    ],
                    hintText: "Celular",
                    keyboardType: TextInputType.emailAddress,
                    controller:
                    loginController.loginWithEmailTextControllers['phone'],
                    label: 'Celular'),
                // callBack: buttonReturnController.updateButton,
                // shouldShowValidateButton: false,
                // autoCorrectActive: false,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(bottom: 16)),
        Container(
          width: Util.getWidth(0.91),
          child: CustomTextField(
              controller:
                  loginController.loginWithEmailTextControllers['password']!,
              field: Field(
                  error: (TextEditingController controller) {
                    final bool strongPassword =
                        RegExp("^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}\$")
                            .hasMatch(controller.value.text);

                    if (!strongPassword && controller.value.text != "") {
                      return "Senha fraca demais";
                    }
                  },
                  controller:
                      loginController.loginWithEmailTextControllers['password'],
                  hintText: "Senha",
                  label: 'Senha'),
              sufixIcon: IconButton(
                icon: Icon(
                  _passwordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 24,
                  color: Util.TextColor,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              callBack: buttonReturnController.updateButton,
              shouldShowValidateButton: false,
              obscureText: !_passwordVisible
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 8),
          width: Util.getWidth(0.91),
          child: Text(
            passwordText,
            style: TextStyle(color: Util.TextColor, fontSize: 10),
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 16)),
        Container(
          width: Util.getWidth(0.91),
          child: CustomTextField(
            controller: loginController
                  .loginWithEmailTextControllers['confirmPassword']!,
              field: Field(
                  error: (TextEditingController controller) {
                    if (loginController
                                .loginWithEmailTextControllers[
                                    'confirmPassword']!
                                .text !=
                            loginController
                                .loginWithEmailTextControllers['password']!
                                .text &&
                        loginController
                                .loginWithEmailTextControllers[
                                    'confirmPassword']!
                                .text !=
                            "") {
                      return "As senhas precisam ser idênticas";
                    }
                  },
                  hintText: "Confirmação de Senha",
                  controller: loginController
                      .loginWithEmailTextControllers['confirmPassword'],
                  label: 'Confirme sua senha'),
              sufixIcon: IconButton(
                icon: Icon(
                  _confirmPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 24,
                  color: Util.HeaderArrow,
                ),
                onPressed: () {
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
                  });
                },
              ),
              shouldShowValidateButton: false,
              callBack: buttonReturnController.updateButton,
              obscureText: !_confirmPasswordVisible,
          ),
        )
      ],
    );
  }
}
