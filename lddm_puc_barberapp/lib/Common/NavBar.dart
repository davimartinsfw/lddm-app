import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Controllers/NavBarController.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late NavBarController navBarController;

  @override
  void initState() {
    super.initState();

    navBarController = context.read<NavBarController>();
  }

  Widget renderIcons(int index) {
    if (navBarController.actualIndex == index) {
      return Container(
        child: SvgPicture.asset(navBarController.list[index].image),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color.fromRGBO(234, 113, 76, 0.1)),
        padding: EdgeInsets.all(16),
      );
    }

    return InkWell(
        onTap: () => navBarController.changeIndex(index),
        child: Container(
          child: SvgPicture.asset(navBarController.list[index].image),
          padding: EdgeInsets.all(16),
        ));
  }

  EdgeInsets renderPadding() {
    if (Platform.isIOS) {
      return EdgeInsets.only(top: 10);
    }

    return EdgeInsets.zero;
  }

  double size() {
    if (Platform.isIOS) {
      return Util.getHeight(0.1);
    }

    return Util.getHeight(0.08);
  }

  MainAxisAlignment align() {
    if(Platform.isIOS) {
      return MainAxisAlignment.start;
    }

    return MainAxisAlignment.center;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<NavBarController>();

    return Container(
      padding: renderPadding(),
      width: Util.getWidth(1),
      height: size(),
      decoration: BoxDecoration(color: Util.PrimaryColor),
      child: Column(
        mainAxisAlignment: align(),
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            renderIcons(0),
            renderIcons(1),
            renderIcons(2),
          ]),
        ],
      ),
    );
  }
}
