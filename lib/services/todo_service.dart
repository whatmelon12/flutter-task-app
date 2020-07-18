import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:todoeyflutter/constants/http.dart';
import 'package:todoeyflutter/model/todo.dart';
import 'package:todoeyflutter/services/auth_service.dart';

class TodoService {
  final String baseUrl = '$kBaseUrl/todo';
  AuthService _authService;

  TodoService(AuthService authService): _authService = authService;

  Future<List<Todo>> getAll() async {
    final token = await _authService.getToken();
    final res = await http.get(baseUrl, headers: {'authorization': 'Bearer $token'});
    if(res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)['message']);
    }

    return List<Todo>.from(jsonDecode(res.body));
  }
}