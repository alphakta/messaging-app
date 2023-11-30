import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/models/user.model.dart';

class UserService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(User user) async {
    await userCollection.doc(user.idUser).set(user.toJson());
  }

  Future<User> getUserById(String userID) async {
    DocumentSnapshot userDoc = await userCollection.doc(userID).get();
    return User(
      idUser: userDoc['idUser'],
      firstName: userDoc['firstName'],
      lastName: userDoc['lastName'],
    );
  }

  Future<List<User>> getAllUsers() async {
    QuerySnapshot users = await userCollection.get();

    List<User> userList = await Future.wait(
      users.docs.map((user) async {
        return User.fromJson(user.data() as Map<String, dynamic>);
      }),
    );

    return userList;
  }
}
