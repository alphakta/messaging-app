// ignore_for_file: unnecessary_this, await_only_futures, avoid_print

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:messaging_app/models/message.model.dart';

class FirebaseProvider extends ChangeNotifier {
  List<Message> messages = [];
  late StreamController<List<Message>> messagesController;

  FirebaseProvider() {
    messagesController = StreamController<List<Message>>.broadcast();
    getMessages();
  }

  Stream<List<Message>> get messagesStream => messagesController.stream;

  Future<void> getMessages() async {
    try {
      await FirebaseFirestore.instance
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(50)
          .snapshots()
          .listen((QuerySnapshot snapshot) {
        this.messages = snapshot.docs
            .map((doc) => Message.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        messagesController.add(this.messages);
      });
    } catch (e) {
      print('Error getting messages: $e');
    }
  }
}
