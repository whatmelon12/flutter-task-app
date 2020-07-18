import 'package:flutter/material.dart';
import 'package:todoeyflutter/model/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final Function(bool) onChanged;
  final Function onLongPress;

  TodoTile({@required this.todo, this.onChanged, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      title: Text(
        todo.title,
        style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            decoration:
                todo.isDone ? TextDecoration.lineThrough : TextDecoration.none),
      ),
      trailing: Checkbox(
        value: todo.isDone,
        activeColor: Colors.lightBlueAccent,
        onChanged: onChanged,
      ),
    );
  }
}
