import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoeyflutter/components/task_indicator_card.dart';

import 'package:todoeyflutter/state/todo_state.dart';
import 'package:todoeyflutter/model/stage.dart';
import 'package:todoeyflutter/services/auth_service.dart';
import 'package:todoeyflutter/services/todo_service.dart';
import 'package:todoeyflutter/constants/styles.dart';
import 'package:todoeyflutter/components/header.dart';
import 'package:todoeyflutter/components/todo_list.dart';
import 'package:todoeyflutter/screens/add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  static final String id = 'TaskScreen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<TodoService, TodoState>(
      create: (_) => TodoState(),
      update: (_, todoService, todoState) => todoState.update(todoService),
      child: TasksScreenContent(),
    );
  }
}

class TasksScreenContent extends StatefulWidget {
  @override
  _TasksScreenContentState createState() => _TasksScreenContentState();
}

class _TasksScreenContentState extends State<TasksScreenContent> {
  bool _refreshing = false;
  GlobalKey<RefreshIndicatorState> key;

  @override
  void initState() {
    super.initState();
    key = GlobalKey<RefreshIndicatorState>();
  }

  Future<void> onRefresh() {
    this.setState(() {
      _refreshing = true;
    });
    return Provider.of<TodoState>(context, listen: false).get().then((value) {
      this.setState(() {
        _refreshing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (mContext) {
                final todoState = Provider.of<TodoState>(context);
                return ChangeNotifierProvider.value(
                  value: todoState,
                  child: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(mContext).viewInsets.bottom),
                        child: AddTaskScreen()),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(top: 60.0, left: 30.0, right: 30, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Header(),
                TaskIndicatorCard(
                  username: context.watch<AuthService>().user.email,
                  tasks: context.watch<TodoState>().todosCount,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: kTopRoundBoxDecoration.copyWith(color: Colors.white),
              child: Provider.of<TodoState>(context).stage == Stage.LOADING &&
                      !_refreshing
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      key: key, onRefresh: onRefresh, child: TodoList()),
            ),
          )
        ],
      ),
    );
  }
}
