class User {
  final String idUser;
  final String firstName;
  final String lastName;

  User({
    required this.idUser,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['idUser'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
