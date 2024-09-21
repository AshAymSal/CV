import 'dart:convert';
import 'package:flutter_web/features/auth/data/models/user_model.dart';
import 'package:flutter_web/features/cart/data/models/cart_model.dart';
import 'package:http/http.dart' as http;

class CartRemoteDataSource {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<List<CartModel>> getUserCarts(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/carts/user/${id}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> body = jsonDecode(response.body);

      List<CartModel> carts =
          body.map((dynamic item) => CartModel.fromJson(item)).toList();
      return carts;
    } else {
      throw Exception('Failed to get carts');
    }
  }

  Future<void> addCart(CartModel c) async {
    final response = await http.post(Uri.parse('$baseUrl/carts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(c.toJson()));

    if (response.statusCode == 200) {
      print("added done");
      print(response.body);
    } else {
      throw Exception('Failed to add cart');
    }
  }
}
