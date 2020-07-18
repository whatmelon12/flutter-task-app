import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Color iconColor;
  final Color iconBackgroundColor;
  final Color color;

  Header(
      {this.iconColor = Colors.lightBlueAccent,
      this.iconBackgroundColor = Colors.white,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
            backgroundColor: iconBackgroundColor,
            radius: 30.0,
            child: Icon(
              Icons.list,
              size: 30.0,
              color: iconColor,
            )),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Todoey',
          style: TextStyle(
              color: color,
              fontSize: 50.0,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
