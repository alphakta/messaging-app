// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, unnecessary_this

import 'package:flutter/material.dart';
import 'package:messaging_app/models/user.model.dart';
import 'package:messaging_app/screens/chat/widgets/message_bubble.widget.dart';
import 'package:messaging_app/screens/chat/widgets/welcome.widget.dart';
import 'package:messaging_app/services/auth.service.dart';
import 'package:messaging_app/services/message.service.dart';
import 'package:messaging_app/services/user.service.dart';
import 'package:messaging_app/models/message.model.dart';
import 'package:messaging_app/provider/firebase.provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? user;
  TextEditingController messageController = TextEditingController();
  ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  Future<void> _setUserData() async {
    String? idUser = AuthService().getCurrentUserUID();
    final user = await UserService().getUserById(idUser!);

    if (mounted) {
      setState(() {
        this.user = user;
      });
    }
  }

  void sendMessage() async {
    String newMessage = messageController.text;
    if (newMessage.isNotEmpty) {
      await MessageService().sendMessage(
        newMessage,
        this.user!.idUser,
        this.user!.firstName,
        this.user!.lastName,
      );
    }
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat général'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AuthService().signOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const WelcomeMessageWidget(),
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: FirebaseProvider().messagesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Erreur de chargement des messages.'),
                  );
                } else {
                  List<Message> messages = snapshot.data ?? [];

                  return ScrollablePositionedList.builder(
                    itemScrollController: itemScrollController,
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      Message message = messages[index];
                      bool isUserMessage =
                          message.senderId == this.user?.idUser;

                      return MessageBubble(
                        message: message,
                        isUserMessage: isUserMessage,
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
                    itemScrollController.jumpTo(index: 0);
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
