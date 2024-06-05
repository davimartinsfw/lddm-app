import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controllers/RouteController.dart';
import '../../Routes/AppRoutes.dart';
import 'BarberCarousel.dart';
import 'NextSchedule.dart';
import 'ProcedureCarousel.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late RouteController routeController;

  @override
  void initState() {
    super.initState();

    routeController = context.read<RouteController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NextSchedule(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: InkWell(
              onTap: () {
                routeController.softPush(AppRoutes.ABOUTUS);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset('assets/img/clube-teste-1.png')),
            ),
          ),
          ProcedureCarousel(),
          BarberCarousel(),
          Padding(padding: EdgeInsets.only(top: 20)),
        ],
      ),
    );
  }
}
