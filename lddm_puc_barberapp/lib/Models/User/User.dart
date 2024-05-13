class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String cellphone;
  final String? birthDate;
  final bool? isClube;
  final bool? isBarber;
  final bool? isAdmin;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.cellphone,
      required this.birthDate,
      required this.isClube,
      required this.isBarber,
      required this.isAdmin});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        password = json['password'] ?? '',
        cellphone = json['phone_number'],
        birthDate = json['birthDate'],
        isClube = renderBoolean(json['is_clube']),
        isBarber = renderBoolean(json['is_barber']),
        isAdmin = renderBoolean(json['is_admin']);

  static bool? renderBoolean(dynamic b) {
    if (b == null) {
      return null;
    }

    if (b.runtimeType == bool) {
      return b;
    }

    if (b == 0) {
      return false;
    }

    if (b == 1) {
      return true;
    }
  }
}
