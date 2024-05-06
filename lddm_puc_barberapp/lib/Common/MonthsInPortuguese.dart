class MonthsInPortuguese {
  List<String> months = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro",
  ];

  List<String> monthsShort = [
    "Jan",
    "Fev",
    "Mar",
    "Abr",
    "Maio",
    "Jun",
    "Jul",
    "Ago",
    "Set",
    "Out",
    "Nov",
    "Dez",
  ];

  List<String> days = [
    "Dom",
    "Seg",
    "Ter",
    "Qua",
    "Qui",
    "Sex",
    "Sáb",
  ];

  String witchMonth(int month) {
    return months[month - 1];
  }

  String witchShortMonth(int month) {
    return monthsShort[month - 1];
  }

  String witchDay(int day) {
    return days[day - 1];
  }
}
