import 'package:flutter/material.dart';
import '../../Common/Util.dart';
import 'LogableButton.dart';

class RoundedButton extends StatefulWidget {
  Map<String, dynamic>? analytics;
  Color color;
  Color borderColor;
  double borderWidth;
  BorderStyle borderStyle;
  Function callBackOnPressed;
  double elevation;
  String text;
  bool isLoading;
  String textLoading;
  bool isDisabled;
  bool shouldShowAdFlag;
  String isDisabledText;
  Color textColor;

  RoundedButton(
      {Key? key,
      required this.text,
      required this.callBackOnPressed,
      this.analytics,
      this.color = Util.SecondaryColor,
      this.borderColor = Colors.transparent,
      this.borderWidth = 0,
      this.borderStyle = BorderStyle.none,
      this.elevation = 3,
      this.isLoading = false,
      this.textLoading = 'Carregando...',
      this.isDisabled = false,
      this.shouldShowAdFlag = false,
      this.isDisabledText = '',
      this.textColor = Util.PrimaryColor})
      : super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  void initState() {
    super.initState();
  }

  Widget getText() {
    if (widget.isLoading) {
      return Text(widget.textLoading,
          style: Util.fontStyleB(16, Util.TextColor),
          textAlign: TextAlign.center);
    }

    if (widget.isDisabled) {
      return Text(
        widget.isDisabledText,
        style: Util.fontStyleB(16, Util.HeaderArrow),
        textAlign: TextAlign.center,
      );
    }

    return Text(widget.text,
        style: Util.fontStyleB(16, widget.textColor),
        textAlign: TextAlign.center);
  }

  Color getBackgroundColor() {
    if (widget.isLoading) {
      return Util.HeaderArrow;
    }

    if (widget.isDisabled) {
      return Util.DisableCalendar;
    }

    return widget.color;
  }

  ButtonStyle getStyle() {
    final backgrounColor = getBackgroundColor();

    return ButtonStyle(
        shadowColor: MaterialStateProperty.all(Color.fromRGBO(0, 0, 0, 0.8)),
        backgroundColor: MaterialStateProperty.all(backgrounColor),
        elevation: MaterialStateProperty.all(widget.elevation),
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 48)),
        side: MaterialStateProperty.all(BorderSide(
            color: widget.borderColor,
            width: widget.borderWidth,
            style: widget.borderStyle)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        )));
  }

  void onTapFunction() {
    if (widget.isDisabled || widget.isLoading) {
      return;
    }

    widget.callBackOnPressed.call();
  }

  @override
  Widget build(BuildContext context) {
    return LogableButton(
      child: getText(),
      onPressed: onTapFunction,
      style: getStyle(),
    );
  }
}
