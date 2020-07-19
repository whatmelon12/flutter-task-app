import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'package:todoeyflutter/model/account.dart';
import 'package:todoeyflutter/constants/styles.dart';
import 'package:todoeyflutter/components/header.dart';
import 'package:todoeyflutter/components/login_form.dart';
import 'package:todoeyflutter/components/error_dialog.dart';
import 'package:todoeyflutter/screens/task_screen.dart';
import 'package:todoeyflutter/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "RegisterScreen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.lightBlueAccent,
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Header(
                iconBackgroundColor: Colors.lightBlueAccent,
                iconColor: Colors.white,
                color: Colors.lightBlueAccent,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
              decoration: kTopRoundBoxDecoration,
              child: LoginForm(
                buttonLabel: 'Register',
                buttonColor: Colors.blueAccent,
                onFormSaved: (account) => _onFormSaved(context, account),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showErrorDialog({String message}) async {
    return showDialog<void>(
        context: context,
        builder: (context) => ErrorDialog(
          title: 'Registration Error',
          message: message,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ));
  }

  _onFormSaved(BuildContext context, Account account) async {
    setState(() {
      _loading = true;
    });

    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.register(account: account);
      Navigator.pushReplacementNamed(context, TasksScreen.id);
    } catch (e) {
      _showErrorDialog(message: e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
