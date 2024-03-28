import 'package:flutter/cupertino.dart';
import 'package:lddm_puc_barberapp/Models/Profile/ProfileField.dart';

import '../Models/Profile/Field.dart';

List<ProfileField> MOCK_PROFILE = [
  ProfileField(
      controllerName: 'name', label: 'Nome', hintText: "Digite seu nome aqui"),
  ProfileField(
      controllerName: 'email',
      label: 'E-mail',
      hintText: "Digite seu e-mail aqui"),
  ProfileField(
      controllerName: 'cellphone',
      error: (TextEditingController controller) {
        final String text = controller.value.text;

        if (text.length > 0 && text.length < 15) {
          return 'O telefone deve ter 11 números';
        }
      },
      formatters: [],
      keyboardType: TextInputType.number,
      label: 'Telefone',
      hintText: "(DDD) 99999-9999",
      mask: '(##) #####-####',
      maskFilter: {"#": RegExp(r'[0-9]')}),
  ProfileField(
      controllerName: 'birthdate',
      error: (TextEditingController controller) {
        final String text = controller.value.text;

        if (text.length > 0 && text.length < 10) {
          return 'Data de Nascimento inválida';
        }

        if (text.length < 10) {
          return null;
        }

        final brokenDate = text.split('/');
        final now = DateTime.now();

        final choosenDate = DateTime.parse(
            '${brokenDate[2]}-${brokenDate[1]}-${brokenDate[0]} 00:00:00.000');

        final condition = choosenDate.isAfter(now) ||
            choosenDate.isAfter(DateTime(now.year - 10, now.month, now.day));

        if (condition) {
          return 'Data de Nascimento inválida';
        }
      },
      formatters: [],
      label: 'Data de nascimento',
      hintText: "dia/mês/ano",
      mask: '##/##/####',
      maskFilter: {"#": RegExp(r'[0-9]')}),
];
