class Barber {
  final String id;
  final String image;
  final String name;

  Barber({
    required this.id,
    required this.image,
    required this.name
});

  Barber.fromJson(Map<String, dynamic> json)
  : id = json['id'],
  name = json['name'],
  image = "assets/img/barber-photo-%id%.png";

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image
  };
}