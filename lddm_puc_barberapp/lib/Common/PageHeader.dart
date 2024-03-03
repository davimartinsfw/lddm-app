import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';

PreferredSizeWidget PageHeader() {
  return PreferredSize(
      preferredSize: Size.fromHeight(47),
      child: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Util.HeaderArrow,
          size: 20,
        ),
        backgroundColor: Util.PrimaryColor,
        leadingWidth: 75,
        centerTitle: true,
        shadowColor: Colors.black12,
        title: FadeIn(
          child: Text(
            "Seu perfil",
            style: Util.fontStyleSB(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "SALVAR",
              style: Util.fontStyleSB(15, Util.SecondaryColor),
            ),
          )
        ],
      ));
}
