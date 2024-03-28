import 'package:flutter/cupertino.dart';
import 'LoginWithEmail.dart';

class LoginController extends ChangeNotifier
    with LoginWithEmail {
  bool showPasswordError = false;

  void setShowPasswordError(bool value) {
    showPasswordError = value;
    notifyListeners();
  }

  bool isCreateAccountFormValid() {
    bool nameValid =
        (loginWithEmailTextControllers['name']?.value.text ?? "").length >= 5;

    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(loginWithEmailTextControllers['email']?.value.text ?? "");

    bool strongPassword = RegExp("^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}\$")
        .hasMatch(loginWithEmailTextControllers['password']?.value.text ?? "");

    bool confirmPasswordValid =
        ((loginWithEmailTextControllers['confirmPassword']?.value.text ?? "") ==
            (loginWithEmailTextControllers['password']?.value.text ??
                "")) &&
            (loginWithEmailTextControllers['confirmPassword']?.value.text !=
                "");

    return nameValid && emailValid && strongPassword && confirmPasswordValid;
  }

  Future<bool> supabaseSignUp() async {
    return false;
  }

  Future<bool> supabaseSignIn(Function onPasswordWrong) async {
    return false;
  }
}
