// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/firebase_options.dart';
import 'package:messaging_app/provider/firebase.provider.dart';
import 'package:messaging_app/screens/auth/auth.sreen.dart';
import 'package:messaging_app/screens/auth/login.screen.dart';
import 'package:messaging_app/screens/auth/signup.screen.dart';
import 'package:messaging_app/screens/chat/chat.screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirebaseProvider>.value(
      value: FirebaseProvider(),
      child: MaterialApp(
        title: 'Messaging App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.grey.shade100,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.purple,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => AuthScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/chat': (context) => ChatScreen(),
        },
      ),
    );
  }
}
