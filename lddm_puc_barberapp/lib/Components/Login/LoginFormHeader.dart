import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Common/Util.dart';
import '../../Controllers/RouteController.dart';

class LoginFormHeader extends StatefulWidget {
  final String title;
  final String desc;

  const LoginFormHeader({super.key, required this.title, required this.desc});

  @override
  State<LoginFormHeader> createState() => _LoginFormHeaderState();
}

class _LoginFormHeaderState extends State<LoginFormHeader> {
  late RouteController routeController;

  @override
  void initState() {
    super.initState();

    routeController = context.read<RouteController>();
  }

  Widget renderTitle() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 42, 16, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: Util.fontStyleSB(20),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.desc,
                style: Util.fontStyle(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget renderBackButton() {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 20),
      child: InkWell(
        onTap: () {
          routeController.softPop();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.arrow_back_ios, color: Util.SecondaryColor, size: 16),
            Text("Voltar",
                style: Util.fontStyleSB())
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        renderBackButton(),
        renderTitle(),
      ],
    );
  }
}
