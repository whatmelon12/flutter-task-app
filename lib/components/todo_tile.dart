import 'package:flutter/material.dart';

import 'package:todoeyflutter/model/todo.dart';
import 'dismiss_card_background.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final Function(bool) onChanged;
  final Function onDismiss;

  TodoTile({@required this.todo, this.onChanged, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      onDismissed: (_) => onDismiss(),
      child: Card(
        margin: EdgeInsets.only(bottom: 20.0),
        elevation: 1.5,
        child: CheckboxListTile(
          value: todo.isDone,
          title: Text(
            todo.title,
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                decoration:
                    todo.isDone ? TextDecoration.lineThrough : TextDecoration.none),
          ),
          activeColor: Colors.lightBlueAccent,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
