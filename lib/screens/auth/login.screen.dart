// ignore_for_file: use_key_in_widget_constructors, avoid_print, nullable_type_in_catch_clause, unnecessary_null_comparison, use_build_context_synchronously, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/services/auth.service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  Future<void> loginUser(BuildContext context) async {
    try {
      UserCredential userCredential = await AuthService().signInWithEmail(
        _emailController.text,
        _passwordController.text,
      );

      if (userCredential.user != null) {
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
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              obscureText: _isPasswordHidden,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                loginUser(context);
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: const Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
