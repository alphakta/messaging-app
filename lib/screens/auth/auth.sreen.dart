import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:messaging_app/screens/auth/login.screen.dart";
import "package:messaging_app/screens/chat/chat.screen.dart";

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return FutureBuilder<bool>(
              builder: (context, adminRoleSnapshot) {
                if (adminRoleSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // or any loading indicator
                } else {
                  return const ChatScreen();
                }
              },
              future: null,
            );
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
