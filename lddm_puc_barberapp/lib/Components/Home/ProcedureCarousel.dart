import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Components/Procedure/ProcedureBox.dart';
import '../../Models/Procedure/Procedure.dart';

class ProcedureCarousel extends StatefulWidget {
  const ProcedureCarousel({super.key});

  @override
  State<ProcedureCarousel> createState() => _ProcedureCarouselState();
}

class _ProcedureCarouselState extends State<ProcedureCarousel> {
  Procedure p =
      Procedure(id: 1, name: "Corte", value: "R\$80,00", duration: "60");

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
          height: Util.getHeight(0.28),
          child: ListView.builder(
            padding: EdgeInsets.only(right: 16),
              shrinkWrap: true,
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, counter) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: ProcedureBox(p: p),
                );
              }),
        ),
      ],
    );
  }
}
