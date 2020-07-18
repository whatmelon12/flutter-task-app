import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoeyflutter/services/todo_service.dart';

import 'package:todoeyflutter/state/todo_state.dart';
import 'package:todoeyflutter/services/auth_service.dart';
import 'package:todoeyflutter/screens/home_screen.dart';
import 'package:todoeyflutter/screens/login_screen.dart';
import 'package:todoeyflutter/screens/task_screen.dart';

void main() => runApp(MultiProvider(
  providers: [
    Provider(
      create: (_) => AuthService(),
    ),
    ProxyProvider<AuthService, TodoService>(
      update: (_, authService, __) => TodoService(authService),
    ),
    ChangeNotifierProxyProvider<TodoService, TodoState>(
      create: (_) => TodoState(),
      update: (_, todoService, todoState) => todoState.update(todoService),
    ),
  ],
  child: TodoeyApp(),
));

class TodoeyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (_) => HomeScreen(),
        LoginScreen.id: (_) => LoginScreen(),
        TasksScreen.id: (_) => TasksScreen(),
      },
    );
  }
}
