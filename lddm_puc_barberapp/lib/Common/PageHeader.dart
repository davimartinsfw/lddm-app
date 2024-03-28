import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';

import '../Controllers/RouteController.dart';

PreferredSizeWidget PageHeader(String pageName, RouteController routeController, [bool shouldShowSaveButton = false, Function? customPop]) {
  Widget renderActions() {
    if(shouldShowSaveButton) {
      return Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          "SALVAR",
          style: Util.fontStyleSB(15, Util.SecondaryColor),
        ),
      );
    }

    return Container();
  }

  return PreferredSize(
      preferredSize: Size.fromHeight(47),
      child: AppBar(
        leading: InkWell(
          onTap: () {
            if(customPop != null) {
              customPop.call();
              return;
            }

            routeController.softPop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Util.HeaderArrow,
            size: 20,
          ),
        ),
        backgroundColor: Util.PrimaryColor,
        leadingWidth: 75,
        centerTitle: true,
        shadowColor: Colors.black12,
        title: FadeIn(
          child: Text(
            pageName,
            style: Util.fontStyleSB(),
          ),
        ),
        actions: [
          renderActions()
        ],
      ));
}
