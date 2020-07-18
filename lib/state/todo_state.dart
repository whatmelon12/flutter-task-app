import 'package:flutter/material.dart';

import 'package:todoeyflutter/model/stage.dart';
import 'package:todoeyflutter/model/todo.dart';
import 'package:todoeyflutter/mixins/model_state.dart';
import 'package:todoeyflutter/services/todo_service.dart';

class TodoState with ChangeNotifier, ModelState {
  TodoService _todoService;
  List<Todo> _todos;

  TodoState() {
    _todos = List<Todo>();
  }

  TodoState update(TodoService todoService) {
    _todoService = todoService;
    get();
    return this;
  }

  List<Todo> get todos {
    return _todos;
  }

  int get todosCount {
    return todos.length;
  }

  Future<void> toggle({int index}) async {
    try {
      final todo = _todos[index];
      todo.toggle();
      await _todoService.toggle(todo: todo);
      updateStage(stage: Stage.DONE);
    } catch (e) {
      _handleError(error: e);
    }
    notifyListeners();
  }

  Future<void> get() async {
    updateStageAndNotify(stage: Stage.LOADING);
    try {
      _todos = await _todoService.getAll();
      updateStage(stage: Stage.DONE);
    } catch (e) {
      _handleError(error: e);
    }
    notifyListeners();
  }

  Future<void> add({Todo todo}) async {
    updateStageAndNotify(stage: Stage.LOADING);
    try {
      final newTodo = await _todoService.create(todo: todo);
      _todos.add(newTodo);
      updateStage(stage: Stage.DONE);
    } catch (e) {
      _handleError(error: e);
    }
    notifyListeners();
  }

  Future<void> remove({int index}) async {
    try {
      await _todoService.remove(todo: _todos[index]);
      _todos.removeAt(index);
      updateStage(stage: Stage.DONE);
    } catch (e) {
     _handleError(error: e);
    }
    notifyListeners();
  }

  _handleError({dynamic error}) {
    print(error);
    updateStage(stage: Stage.ERROR);
  }
}
