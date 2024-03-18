import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';

class SmallRoundedButton extends StatefulWidget {
  final String txt;
  final Function callBack;
  final Color background;

  const SmallRoundedButton(
      {super.key,
        required this.txt,
        required this.callBack,
        this.background = Util.SecondaryColor});

  @override
  State<SmallRoundedButton> createState() => _SmallRoundedButtonState();
}

class _SmallRoundedButtonState extends State<SmallRoundedButton> {
  ButtonStyle getButtonStyle() {
    return ButtonStyle(
        shadowColor: MaterialStateProperty.all(Color.fromRGBO(0, 0, 0, 0.8)),
        backgroundColor: MaterialStateProperty.all(widget.background),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 26)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )));
  }

  void onTapFunction() {
    widget.callBack.call();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTapFunction,
        child: Text(widget.txt, style: Util.fontStyleSB(12.5, Util.PrimaryColor)),
        style: getButtonStyle());
  }
}
