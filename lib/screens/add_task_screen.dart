import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoeyflutter/constants/styles.dart';
import 'package:todoeyflutter/model/notifiers/todo_notifier.dart';
import 'package:todoeyflutter/model/todo.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        decoration: kTopRoundBoxDecoration.copyWith(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 35.0,
                ),
              ),
              TextField(
                autofocus: true,
                onChanged: (value) {
                  label = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                color: Colors.lightBlueAccent,
                onPressed: () {
                  if(label != null && label.isNotEmpty) {
                    context.read<TodosNotifier>().add(todo: Todo(
                        title: label.trim()
                    ));
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
