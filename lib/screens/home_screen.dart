import 'package:flutter/material.dart';
import 'package:todoeyflutter/components/header.dart';
import 'package:todoeyflutter/components/round_button.dart';
import 'package:todoeyflutter/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Header(
              iconBackgroundColor: Colors.lightBlueAccent,
              iconColor: Colors.white,
              color: Colors.lightBlueAccent,
            ),
            RoundButton(
              label: 'Login',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundButton(
              label: 'Register',
              color: Colors.blueAccent,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
