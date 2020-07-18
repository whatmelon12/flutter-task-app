import 'package:flutter/material.dart';

class TaskIndicatorCard extends StatelessWidget {
  final String username;
  final int tasks;

  TaskIndicatorCard({this.username, this.tasks});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          username,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          '$tasks Tasks',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ],
    );
  }
}
