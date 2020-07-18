import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoeyflutter/state/todo_state.dart';
import 'package:todoeyflutter/components/todo_tile.dart';

class TodoList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoState>(
      builder: (_, todoState, __) => ListView.builder(
        itemBuilder: (context, index) => TodoTile(
          todo: todoState.todos[index],
          onChanged: (value) {
            todoState.toggle(index: index);
          },
          onLongPress: () {
            todoState.remove(index: index);
          },
        ),
        itemCount: todoState.todosCount,
      ),
    );
  }
}
