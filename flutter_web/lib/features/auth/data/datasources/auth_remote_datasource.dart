import 'dart:convert';
import 'package:flutter_web/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<UserModel> login(
      {required String username, required String password}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return _getUserData();
    } else {
      throw Exception('Failed to auth');
    }
  }

  Future<UserModel> _getUserData() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/1'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print(response.body);
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get user');
    }
  }
}
