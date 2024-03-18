import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Components/Common/RoundedButton.dart';
import 'package:lddm_puc_barberapp/Components/Common/SmallRoundedButton.dart';
import 'package:lddm_puc_barberapp/Models/Procedure/Procedure.dart';

class ProcedureBox extends StatefulWidget {
  final Procedure p;

  const ProcedureBox({super.key, required this.p});

  @override
  State<ProcedureBox> createState() => _ProcedureBoxState();
}

class _ProcedureBoxState extends State<ProcedureBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: Util.getWidth(0.4),
        height: Util.getHeight(0.2),
        padding: EdgeInsets.fromLTRB(10,10,10,0),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Util.PrimaryColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: Util.getBoxShadow()
        ),
        child: Column(
          children: [
            //SvgPicture.asset("assets/img/procedure-example.svg")
            Container(
              margin: EdgeInsets.only(bottom: 8),
              height: Util.getHeight(0.13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Util.TextColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.p.name, style: Util.fontStyleSB()),
              ],
            ),
            Row(
              children: [
                Text(widget.p.duration + " min", style: Util.fontStyle(11,Util.HeaderArrow)),
                Text(" • ", style: Util.fontStyle(11,Util.HeaderArrow)),
                Text(widget.p.value, style: Util.fontStyle(11,Util.HeaderArrow)),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 8)),
            Container(width: Util.getWidth(0.2) ,child: SmallRoundedButton(txt: "Agendar", callBack: () {}))
          ],
        ),
    );
  }
}
