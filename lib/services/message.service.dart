import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getMessages() async {
    QuerySnapshot querySnapshot = await _firestore.collection('messages').get();
    List<String> messages =
        querySnapshot.docs.map((doc) => doc['content'] as String).toList();
    return messages;
  }

  Future<void> sendMessage(String newMessage, String idUser) async {
    DocumentReference documentReference =
        await _firestore.collection('messages').add({
      'senderId': idUser,
      'content': newMessage,
      'timestamp': DateTime.now(),
    });
    String messageId = documentReference.id;
    await documentReference.update({'messageId': messageId});
  }
}
