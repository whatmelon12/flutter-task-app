import 'package:flutter/material.dart';

import '../todo.dart';

class TodosNotifier with ChangeNotifier {
  List<Todo> _todos;

  TodosNotifier() {
    _todos = [
      Todo(title: 'Buy milk'),
      Todo(title: 'Walk the dog'),
      Todo(title: 'Do not leave the fridge door opened')
    ];
  }

  List<Todo> get todos {
    return _todos;
  }

  int get todosCount {
    return todos.length;
  }

  toggle({int index}) {
    _todos[index].toggle();
    notifyListeners();
  }

  add({Todo todo}) {
    _todos.add(todo);
    notifyListeners();
  }

  remove({int index}) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
