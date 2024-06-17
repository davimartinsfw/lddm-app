import 'package:flutter/cupertino.dart';
import 'package:lddm_puc_barberapp/Components/Procedure/BarberBox.dart';
import 'package:lddm_puc_barberapp/Controllers/ScheduleController.dart';
import 'package:provider/provider.dart';
import '../../Common/Util.dart';

class BarberCarousel extends StatefulWidget {
  const BarberCarousel({super.key});

  @override
  State<BarberCarousel> createState() => _BarberCarouselState();
}

class _BarberCarouselState extends State<BarberCarousel> {
  late ScheduleController scheduleController;

  @override
  void initState() {
    super.initState();

    scheduleController = context.read<ScheduleController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("Nossos Barbeiros", style: Util.fontStyleSB(20))],
          ),
        ),
        Container(
          width: Util.getWidth(1),
          height: Util.getHeight(0.26),
          child: ListView.builder(
              padding: EdgeInsets.only(right: 16),
              shrinkWrap: true,
              itemCount: scheduleController.barberList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, counter) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child:
                      BarberBox(barber: scheduleController.barberList[counter], photoId: counter),
                );
              }),
        ),
      ],
    );
  }
}
