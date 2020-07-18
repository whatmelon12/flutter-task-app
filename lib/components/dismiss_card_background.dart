import 'package:flutter/material.dart';

class DismissCardBackground extends StatelessWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;
  final IconData leftIcon;
  final IconData rightIcon;
  final Color iconColor;

  DismissCardBackground(
      {this.padding = const EdgeInsets.symmetric(horizontal: 20.0),
      this.margin = const EdgeInsets.only(bottom: 20.0),
      this.color = Colors.lightBlueAccent,
      this.leftIcon = Icons.star,
      this.rightIcon = Icons.star,
      this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: padding,
      margin: margin,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            leftIcon,
            color: iconColor,
          ),
          Icon(
            rightIcon,
            color: iconColor,
          )
        ],
      ),
    );
  }
}
