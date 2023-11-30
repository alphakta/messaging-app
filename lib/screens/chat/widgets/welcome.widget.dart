import 'package:flutter/material.dart';

class WelcomeMessageWidget extends StatelessWidget {
  const WelcomeMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Bienvenue sur le chat général',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
