import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controllers/RouteController.dart';

class LogableButton extends StatefulWidget {
  final Widget? child;
  final dynamic icon;
  final Widget? label;
  final onPressed;
  final style;

  const LogableButton({
    Key? key,
    this.child,
    this.label,
    required this.onPressed,
    this.style,
    this.icon,
  }) : super(key: key);

  @override
  State<LogableButton> createState() => _LogableButtonState();
}

class _LogableButtonState extends State<LogableButton> {
  late RouteController routeController;

  @override
  void initState() {
    super.initState();

    routeController = context.read<RouteController>();
  }

  void onPressedCallback() {
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return widget.icon != null
        ? (
        ElevatedButton.icon(
          icon: widget.icon,
          onPressed: onPressedCallback,
          label: widget.label ?? Text(''),
          style: widget.style,
        )
    )
        : (
        ElevatedButton(
          onPressed: onPressedCallback,
          child: widget.child,
          style: widget.style,
        )
    );
  }
}
