import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function onPressed;

  ErrorDialog(
      {@required this.title, @required this.message, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[Text(message)],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Accept', style: TextStyle(color: Colors.red),),
          onPressed: onPressed,
        )
      ],
    );
  }
}
