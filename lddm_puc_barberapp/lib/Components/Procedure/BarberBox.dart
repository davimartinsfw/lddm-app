import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Common/Util.dart';
import '../../Models/Procedure/Barber.dart';
import '../Common/SmallRoundedButton.dart';

class BarberBox extends StatefulWidget {
  final Barber barber;

  const BarberBox({super.key, required this.barber});

  @override
  State<BarberBox> createState() => _BarberBoxState();
}

class _BarberBoxState extends State<BarberBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Util.getWidth(0.4),
      height: Util.getHeight(0.29),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Util.PrimaryColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: Util.getBoxShadow()
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //SvgPicture.asset(widget.barber.image),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            width: Util.getHeight(0.13),
            height: Util.getHeight(0.13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Util.TextColor,
            ),
          ),
          Text(widget.barber.name, style: Util.fontStyleSB()),
          Padding(padding: EdgeInsets.only(bottom: 8)),
          Container(width: Util.getWidth(0.2) ,child: SmallRoundedButton(txt: "Conhecer", callBack: () {}))
        ],
      ),
    );
  }
}
