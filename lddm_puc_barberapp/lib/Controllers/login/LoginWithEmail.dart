import 'package:flutter/material.dart';

mixin LoginWithEmail {
  Map<String, TextEditingController> loginWithEmailTextControllers = {
    'email': TextEditingController(),
    'name': TextEditingController(),
    'cpf': TextEditingController(),
    'password': TextEditingController(),
    'phone': TextEditingController(),
    'recoverCode': TextEditingController(),
    'recoverPassword': TextEditingController(),
    'recoverPasswordConfirm': TextEditingController(),
    'confirmPassword': TextEditingController(),
  };
}