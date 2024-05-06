import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/Procedure/Procedure.dart';

class ProcedureService {
  final path = 'http://localhost:3000/api/procedure';

  Future<List<Procedure>> getProcedure() async {
    Uri uri = Uri.parse("$path/");

    final response = await http.get(uri,
        headers: {
          'content-type': 'application/json',
        });

    final rawResponse = jsonDecode(response.body);

    final List<Procedure> procedureList =
    List.from(rawResponse.map((element) => Procedure.fromJson(element)));

    return procedureList;
  }
}