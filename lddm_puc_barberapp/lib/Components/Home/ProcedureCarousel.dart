import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Components/Procedure/ProcedureBox.dart';
import 'package:lddm_puc_barberapp/data/procedureMock.dart';
import '../../Models/Procedure/Procedure.dart';

class ProcedureCarousel extends StatefulWidget {
  const ProcedureCarousel({super.key});

  @override
  State<ProcedureCarousel> createState() => _ProcedureCarouselState();
}

class _ProcedureCarouselState extends State<ProcedureCarousel> {
  List<Procedure> p = MOCK_PROCEDURE;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.start ,children: [
            Text("Escolha nosso serviço", style: Util.fontStyleSB(20))
          ],),
        ),
        Container(
          width: Util.getWidth(1),
          height: Util.getHeight(0.26),
          child: ListView.builder(
            padding: EdgeInsets.only(right: 16),
              shrinkWrap: true,
              itemCount: p.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, counter) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: ProcedureBox(p: p[counter]),
                );
              }),
        ),
      ],
    );
  }
}
