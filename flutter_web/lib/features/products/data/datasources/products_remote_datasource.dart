import 'dart:convert';
import 'package:flutter_web/features/products/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsRemoteDataSource {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ProductModel> products =
          body.map((dynamic item) => ProductModel.fromJson(item)).toList();
      // print(products);
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<ProductModel> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List> fetchCategories() async {
    //print("eoo");
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));
    // print(response.body);

    if (response.statusCode == 200) {
      //print("www");
      var body = jsonDecode(response.body);
      //  List<CategoryModel> cat =
      //    body.map((dynamic item) => CategoryModel.fromJson(item)).toList();
      //print("caat");
      //print(body);

      return body; //List<CategoryModel>.from(body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    final response =
        await http.get(Uri.parse('$baseUrl/products/category/$category'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ProductModel> products =
          body.map((dynamic item) => ProductModel.fromJson(item)).toList();
      // print(products);
      return products;
    } else {
      throw Exception('Failed to load products by category');
    }
  }

  Future<ProductModel> addProduct(ProductModel product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add product');
    }
  }

  Future<ProductModel> updateProduct(ProductModel product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}
