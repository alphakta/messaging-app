// ignore_for_file: use_key_in_widget_constructors, avoid_print, nullable_type_in_catch_clause, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/services/auth.service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    try {
      User user = AuthService().signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      ) as User;

      if (user != null) {
        Navigator.pushReplacementNamed(context, '/chat');
      } else {
        print('Utilisateur non trouvé');
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('Aucun utilisateur trouvé pour cet email.');
      } else if (error.code == 'wrong-password') {
        print('Mot de passe incorrect.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                print('Email: ${emailController.text}');
                print('Password: ${passwordController.text}');
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                loginUser(context);
              },
              child: const Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
