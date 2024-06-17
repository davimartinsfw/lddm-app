class Procedure {
  final String id;
  final String name;
  final int value;
  final int duration;

  Procedure({
    required this.id,
    required this.name,
    required this.value,
    required this.duration,
  });

  Procedure.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        value = json['value'],
        duration = json['duration'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'type': name, 'price': value, 'duration': duration};
}
