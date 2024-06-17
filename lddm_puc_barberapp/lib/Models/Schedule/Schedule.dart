import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lddm_puc_barberapp/Models/User/User.dart';

class Schedule {
  String id;
  DocumentReference<Map<String, dynamic>>? userId;
  DocumentReference<Map<String, dynamic>>? barberId;
  DocumentReference<Map<String, dynamic>>? procedureId;
  DateTime? horario;
  String? descricao;
  String? fotoAtual;
  String? fotoCorte;

  Schedule(
      {required this.id ,required this.userId,
      required this.barberId,
      required this.procedureId,
      required this.horario,
      this.descricao,
      this.fotoAtual,
      this.fotoCorte});

  Schedule.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        barberId = json['barber_id'],
        procedureId = json['procedure_id'],
        horario = renderTime(json['start_time']),
        descricao = json['description'],
        fotoAtual = json['foto_atual'],
        fotoCorte = json['foto_corte'];

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'barber_id': barberId,
        'procedure_id': procedureId,
        'start_time': horario.toString(),
        'description': descricao,
        'foto_atual': fotoAtual,
        'foto_corte': fotoCorte
      };

  static DateTime? renderTime(dynamic t) {
    if (t.runtimeType == String) {
      return DateTime.parse(t).subtract(const Duration(hours: 3));
    }

    return t.toDate().subtract(const Duration(hours: 3));
  }
}
