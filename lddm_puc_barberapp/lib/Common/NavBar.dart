import 'package:flutter/material.dart';
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
        child: Icon(
          Icons.home,
          size: 34,
          color: Util.SecondaryColor,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color.fromRGBO(234, 113, 76, 0.1)),
        padding: EdgeInsets.all(6),
      );
    }

    return InkWell(
        onTap: () => navBarController.changeIndex(index),
        child: Container(
          child: Icon(
            Icons.home,
            size: 34,
          ),
          padding: EdgeInsets.all(6),
        ));
  }

  @override
  Widget build(BuildContext context) {
    context.watch<NavBarController>();

    return Container(
      width: Util.getWidth(1),
      height: Util.getHeight(0.1),
      decoration: BoxDecoration(color: Util.PrimaryColor),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        renderIcons(0),
        renderIcons(1),
        renderIcons(2),
      ]),
    );
  }
}
