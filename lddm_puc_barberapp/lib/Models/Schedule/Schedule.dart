import 'package:lddm_puc_barberapp/Models/User/User.dart';

class Schedule {
  int? userId;
  int? barberId;
  int? procedureId;
  DateTime? horario;
  String? descricao;
  String? fotoAtual;
  String? fotoCorte;

  Schedule({
    required this.userId,
    required this.barberId,
    required this.procedureId,
    required this.horario,
    this.descricao,
    this.fotoAtual,
    this.fotoCorte
});

  Schedule.fromJson(Map<String, dynamic> json)
  : userId = json['user_id'],
  barberId = json['barber_id'],
  procedureId = json['procedure_id'],
  horario = DateTime.parse(json['horario']).subtract(Duration(hours: 3)),
  descricao = json['descricao'],
  fotoAtual = json['foto_atual'],
  fotoCorte = json['foto_corte'];

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'barber_id': barberId,
    'procedure_id': procedureId,
    'horario': horario.toString(),
    'descricao': descricao,
    'foto_atual': fotoAtual,
    'foto_corte': fotoCorte
  };
}