import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> criaTabela(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS user(
id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(80) UNIQUE NOT NULL,
    is_admin num,
    is_barber num,
    is_clube num,
    date_birth DATE,
    phone_number VARCHAR(11) NOT NULL
)
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'user.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await criaTabela(database);
      },
    );
  }

  static Future<int> adicionarProduto(int userId, String name, String email, String number,
      String birthDate, bool isAdmin, bool isBarber, bool isClube) async {
    final db = await SQLHelper.db();
    final dados = {
      'id': userId,
      'name': name,
      'email': email,
      'phone_number': number,
      'date_birth': birthDate,
      'is_admin': isAdmin ? 1 : 0,
      'is_barber': isBarber ? 1 : 0,
      'is_clube': isClube ? 1 : 0
    };
    final id = await db.insert('user', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> pegaUser() async {
    final db = await SQLHelper.db();
    return db.query('user', orderBy: "id");
  }
}
