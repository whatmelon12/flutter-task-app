import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todoeyflutter/constants/http.dart';
import 'package:todoeyflutter/model/account.dart';
import 'package:todoeyflutter/model/user.dart';

class AuthService {
  final String baseUrl = '$kBaseUrl/account';
  User _user;

  login({Account account}) async {
    final res = await http.post('$baseUrl/login',
        body: json.encode(account),
        headers: {'content-type': 'application/json'});
    _handleStatusCode(response: res);

    final user = User.fromJson(json.decode(res.body));
    await _saveAuthenticatedUser(user: user);
  }

  register({Account account}) async {
    final res = await http.post('$baseUrl/register',
        body: json.encode(account),
        headers: {'content-type': 'application/json'});
    _handleStatusCode(response: res);

    final user = User.fromJson(json.decode(res.body));
    await _saveAuthenticatedUser(user: user);
  }

  Future<bool> authenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get('token');
  }

  User get user {
    return _user;
  }

  Future<User> getUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final user = User.fromJson(json.decode(prefs.get('user')));
    _user = user;
    return user;
  }

  _saveAuthenticatedUser({User user}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', user.token);
    prefs.setString('user', json.encode(user));
    _user = user;
  }

  _handleStatusCode({http.Response response}) {
    if (response.statusCode < 200 || response.statusCode > 300) {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
