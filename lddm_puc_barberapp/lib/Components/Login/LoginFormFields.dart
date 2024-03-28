import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Common/Util.dart';
import '../../../../Routes/AppRoutes.dart';
import '../../Controllers/ButtonReturnController.dart';
import '../../Controllers/login/LoginController.dart';
import '../../Models/Profile/Field.dart';
import '../Common/CustomTextField.dart';

class LoginFormFields extends StatefulWidget {
  const LoginFormFields({super.key});

  @override
  State<LoginFormFields> createState() => _LoginFormFieldsState();
}

class _LoginFormFieldsState extends State<LoginFormFields> {
  bool _passwordVisible = false;
  int passwordSendLength = 0;
  late LoginController loginController;
  late ButtonReturnController buttonReturnController;

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
                callBack: buttonReturnController.updateButton,
                shouldShowValidateButton: false,
                autoCorrectActive: false,
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
                    if (loginController.showPasswordError &&
                        controller.value.text.length != passwordSendLength &&
                        passwordSendLength != 0) {
                      passwordSendLength = 0;

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        loginController.setShowPasswordError(false);
                      });
                    }

                    if (loginController.showPasswordError) {
                      passwordSendLength = controller.value.text.length;
                      return "Senha incorreta";
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
                  color: Util.HeaderArrow,
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
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 12, bottom: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.LOGIN);
                },
                child: Text(
                  "Esqueci a senha",
                  style: Util.fontStyle(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
