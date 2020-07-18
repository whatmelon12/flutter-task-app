import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:todoeyflutter/constants/http.dart';
import 'package:todoeyflutter/model/todo.dart';
import 'package:todoeyflutter/services/auth_service.dart';

class TodoService {
  final String baseUrl = '$kBaseUrl/todo';
  AuthService _authService;

  TodoService(AuthService authService) : _authService = authService;

  Future<List<Todo>> getAll() async {
    final token = await _authService.getToken();
    final res =
        await http.get(baseUrl, headers: {'authorization': 'Bearer $token'});
    _handleStatusCode(response: res);

    return jsonDecode(res.body)
        .map((i) => Todo.fromJson(i))
        .cast<Todo>()
        .toList();
  }

  Future<Todo> create({Todo todo}) async {
    final token = await _authService.getToken();
    final res = await http.post(baseUrl,
        headers: {
          'authorization': 'Bearer $token',
          'content-type': 'application/json'
        },
        body: jsonEncode(todo.toJson()));
    _handleStatusCode(response: res);

    return Todo.fromJson(jsonDecode(res.body));
  }

  Future<Todo> toggle({Todo todo}) async {
    final token = await _authService.getToken();
    final json = jsonEncode({'isDone': todo.isDone});
    final res = await http.patch('$baseUrl/${todo.id}',
        headers: {
          'authorization': 'Bearer $token',
          'content-type': 'application/json'
        },
        body: json);
    _handleStatusCode(response: res);

    return Todo.fromJson(jsonDecode(res.body));
  }

  Future<void> remove({Todo todo}) async {
    final token = await _authService.getToken();
    final res = await http.delete('$baseUrl/${todo.id}', headers: {
      'authorization': 'Bearer $token',
    });
    _handleStatusCode(response: res);
  }

  _handleStatusCode({http.Response response}) {
    if (response.statusCode < 200 || response.statusCode > 300) {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
