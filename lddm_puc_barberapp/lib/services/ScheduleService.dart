import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lddm_puc_barberapp/Models/Schedule/Schedule.dart';

class ScheduleService {
  final path = 'http://localhost:3000/api/user/schedule';

  Future<bool> createSchedule(Schedule s) async {
    Uri uri = Uri.parse("$path/create");

    final body = jsonEncode(s.toJson());

    final response = await http.post(uri,
        headers: {
          'content-type': 'application/json',
        },
        body: body);

    final rawResponse = jsonDecode(response.body);

    return response.statusCode == 201;
  }

  Future<List<Schedule>> getUserSchedule(int userId) async {
    Uri uri = Uri.parse("$path/user/$userId");

    final response = await http.get(uri,
        headers: {
          'content-type': 'application/json',
        });

    final rawResponse = jsonDecode(response.body);

    final List<Schedule> scheduleList =
    List.from(rawResponse.map((element) => Schedule.fromJson(element)));

    return scheduleList;
  }
}
