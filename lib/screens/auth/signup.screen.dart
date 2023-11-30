// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, avoid_print, unnecessary_null_comparison, unused_field, use_build_context_synchronously, library_prefixes, unnecessary_cast

import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:messaging_app/services/auth.service.dart';
import 'package:messaging_app/services/user.service.dart';
import 'package:messaging_app/models/user.model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  bool _isPasswordHidden = true;
  bool _isLoading = false;

  Future<void> signupUser(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      FirebaseAuth.UserCredential userCredential =
          await AuthService().registerWithEmail(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
        _lastNameController.text,
      );

      if (userCredential.user != null) {
        String idUser = userCredential.user!.uid;
        User newUser = User(
          idUser: idUser,
          firstName: _nameController.text,
          lastName: _lastNameController.text,
        );
        await UserService().createUser(newUser);
        Navigator.pushReplacementNamed(context, '/chat');
      } else {
        print('Utilisateur non trouvé');
      }
    } on FirebaseAuth.FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        print('Le mot de passe est trop faible.');
      } else if (error.code == 'email-already-in-use') {
        print('Un compte existe déjà pour cet email.');
      }
    } catch (error) {
      print(error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: _isPasswordHidden,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signupUser(context);
                  }
                },
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Signup'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Already have an account ? Login.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
