// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, unused_local_variable, library_private_types_in_public_api, unnecessary_null_comparison, unused_field

import 'package:flutter/material.dart';
import 'package:messaging_app/models/user.model.dart';
import 'package:messaging_app/services/auth.service.dart';
import 'package:messaging_app/services/message.service.dart';
import 'package:messaging_app/services/user.service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? _user;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  Future<void> _setUserData() async {
    String? idUser = AuthService().getCurrentUserUID();
    final user = await UserService().getUserById(idUser!);
    setState(() {
      _user = user;
    });
  }

  void sendMessage() {
    String newMessage = messageController.text;
    if (newMessage.isNotEmpty) {
      MessageService().sendMessage(newMessage, _user!.idUser);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: MessageService().getMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Erreur de chargement des messages.'));
                } else {
                  List<String> messages = snapshot.data as List<String>;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(messages[index]),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Entrez votre message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
