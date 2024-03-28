import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Common/Util.dart';
import '../../../../Routes/AppRoutes.dart';
import '../../Controllers/ButtonReturnController.dart';
import '../../Controllers/RouteController.dart';
import '../../Controllers/login/LoginController.dart';
import '../Common/RoundedButton.dart';

class CreateAccountButton extends StatefulWidget {
  const CreateAccountButton({Key? key}) : super(key: key);

  @override
  State<CreateAccountButton> createState() => _CreateAccountButtonState();
}

class _CreateAccountButtonState extends State<CreateAccountButton> {
  late LoginController loginController;
  late ButtonReturnController buttonReturnController;
  late RouteController routeController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loginController = context.read<LoginController>();
    buttonReturnController = context.read<ButtonReturnController>();
    routeController = context.read<RouteController>();
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

          await loginController.supabaseSignUp();

          setState(() {
            isLoading = false;
          });

          routeController.softPush(AppRoutes.HOME);

          // Timer(Duration(seconds: 1), () {
          //   Navigator.pushNamed(context, AppRoutes.LOADING, arguments: model);
          // });
          //
          // loginController.updateUserSignedWithEmail();
        },
      ),
    );
  }
}
