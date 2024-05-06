import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lddm_puc_barberapp/Models/User/User.dart';
import '../Models/Procedure/Barber.dart';

class UserService {
  final path = 'http://localhost:3000/api/user';

  Future<User?> postUser(Object user) async {
    Uri uri = Uri.parse("$path/create");

    final body = jsonEncode({"user": user});

    final response = await http.post(uri,
        headers: {
          'content-type': 'application/json',
        },
        body: body);

    final rawResponse = jsonDecode(response.body);

    return response.statusCode == 201 ? User.fromJson(rawResponse) : null;
  }

  Future<User?> login(Object userLogin) async {
    Uri uri = Uri.parse("$path/login");

    final body = jsonEncode(userLogin);

    final response = await http.post(uri,
        headers: {
          'content-type': 'application/json',
        },
        body: body);

    final rawResponse = jsonDecode(response.body);

    return response.statusCode == 200 ? User.fromJson(rawResponse) : null;
  }

  Future<User?> getUser(int id) async {
    Uri uri = Uri.parse("$path/$id");

    final response = await http.get(uri, headers: {
      'content-type': 'application/json',
    });

    final rawResponse = jsonDecode(response.body);

    return response.statusCode == 200 ? User.fromJson(rawResponse) : null;
  }

  Future<List<Barber>> getBarbers() async {
    Uri uri = Uri.parse("$path/barbers");

    final response = await http.get(uri, headers: {
      'content-type': 'application/json',
    });

    final rawResponse = jsonDecode(response.body);

    final List<Barber> barbersList =
        List.from(rawResponse.map((element) => Barber.fromJson(element)));

    return barbersList;
  }

  Future<bool> deleteUser(int userId) async {
    Uri uri = Uri.parse("$path/delete/$userId");

    final response = await http.delete(uri, headers: {
      'content-type': 'application/json',
    });

    final rawResponse = jsonDecode(response.body);

    return response.statusCode == 200;
  }

  Future<bool> updateUser(int userId, Map<String, dynamic> body) async {
    Uri uri = Uri.parse("$path/update/$userId");

    final response = await http.post(uri,
        headers: {
          'content-type': 'application/json',
        },
        body: jsonEncode(body));

    final rawResponse = jsonDecode(response.body);

    return response.statusCode == 200;
  }
}
