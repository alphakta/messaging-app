class User {
  final String idUser;
  final String name;
  final String lastName;

  User({
    required this.idUser,
    required this.name,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['idUser'],
      name: json['name'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'name': name,
      'lastName': lastName,
    };
  }
}
