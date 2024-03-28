import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Components/CalendarView/TimeCounter.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Controllers/ScheduleController.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Common/Util.dart';

class CalendarSelector extends StatefulWidget {
  const CalendarSelector({super.key});

  @override
  State<CalendarSelector> createState() => _CalendarSelectorState();
}

class _CalendarSelectorState extends State<CalendarSelector> {
  DateTime focused = DateTime.now();
  int index = 0;
  late ScheduleController scheduleController;
  late RouteController routeController;

  @override
  void initState() {
    super.initState();

    scheduleController = context.read<ScheduleController>();
    routeController = context.read<RouteController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scheduleController.updateTime(focused);
    });
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      focused = day;
    });

    scheduleController.updateTime(day);
  }

  Widget renderCalendar() {
    return TableCalendar(
      locale: Localizations.localeOf(context).languageCode,
      focusedDay: focused,
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(Duration(days: 7)),
      availableGestures: AvailableGestures.all,
      calendarFormat: CalendarFormat.week,
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronMargin: EdgeInsets.zero,
          rightChevronMargin: EdgeInsets.zero,
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Util.HeaderArrow,
          ),
          titleTextStyle: Util.fontStyleSB(15, Util.HeaderArrow),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: Util.HeaderArrow,
          )),
      selectedDayPredicate: (day) => isSameDay(day, focused),
      onDaySelected: _onDaySelected,
      weekendDays: [DateTime.sunday],
      calendarStyle: CalendarStyle(
          tablePadding: EdgeInsets.only(left: 10, right: 10),
          selectedDecoration: BoxDecoration(
              boxShadow: Util.getBoxShadow(),
              color: Util.SecondaryColor,
              borderRadius: BorderRadius.circular(8)),
          selectedTextStyle:
              TextStyle(color: Util.PrimaryColor, fontWeight: FontWeight.w700),
          disabledDecoration: BoxDecoration(
              boxShadow: Util.getBoxShadow(),
              color: Util.DisableCalendar,
              borderRadius: BorderRadius.circular(8)),
          disabledTextStyle: TextStyle(color: Util.HeaderArrow),
          defaultDecoration: BoxDecoration(
              boxShadow: Util.getBoxShadow(),
              color: Util.PrimaryColor,
              borderRadius: BorderRadius.circular(8)),
          defaultTextStyle: TextStyle(color: Util.TextColor),
          todayDecoration: BoxDecoration(
              boxShadow: Util.getBoxShadow(),
              color: Util.PrimaryColor,
              borderRadius: BorderRadius.circular(8)),
          todayTextStyle: TextStyle(color: Util.TextColor)),
    );
  }

  Widget renderComponent(int i) {
    return InkWell(
      onTap: () async {
        setState(() {
          index = i;
        });

        await Future.delayed(Duration(milliseconds: 500));

        routeController.softPush(AppRoutes.CONFIRMSCHEDULE);
      },
      child: Container(
        decoration: BoxDecoration(
            color: i == index ? Util.SecondaryColor : Util.PrimaryColor,
            boxShadow: Util.getBoxShadow(),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          TimeCounter().getTime(i),
          style: i == index
              ? Util.fontStyleSB(16, Util.PrimaryColor)
              : Util.fontStyle(16, Util.TextColor),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 0, top: 20, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Qual o melhor dia?", style: Util.fontStyleSB(20)),
              ],
            )),
        renderCalendar(),
        Padding(
            padding: EdgeInsets.only(bottom: 20, top: 20, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("E qual o melhor horário?", style: Util.fontStyleSB()),
              ],
            )),
        Container(
          height: Util.getHeight(0.4),
          width: Util.getWidth(1),
          child: GridView.count(
            childAspectRatio: 2,
            primary: false,
            padding: EdgeInsets.only(bottom: 20, left: 16, right: 16),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            crossAxisCount: 4,
            children: [
              renderComponent(1),
              renderComponent(2),
              renderComponent(3),
              renderComponent(4),
              renderComponent(5),
              renderComponent(6),
              renderComponent(7),
              renderComponent(8),
              renderComponent(9),
              renderComponent(10),
              renderComponent(11),
              renderComponent(12),
              renderComponent(13),
              renderComponent(14),
              renderComponent(15),
              renderComponent(16),
              renderComponent(17),
              renderComponent(18),
              renderComponent(19),
              renderComponent(20),
            ],
          ),
        )
      ],
    );
  }
}
