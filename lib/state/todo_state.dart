import 'package:flutter/material.dart';
import 'package:todoeyflutter/model/todo.dart';
import 'package:todoeyflutter/services/todo_service.dart';

class TodoState with ChangeNotifier {
  TodoService _todoService;
  List<Todo> _todos;
  bool loading = false;

  TodoState() {
    _todos = List<Todo>();
  }

  TodoState update(TodoService todoService) {
    _todoService = todoService;
    return this;
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

  get() async {
    final todos = await _todoService.getAll();
    _todos = todos;
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
