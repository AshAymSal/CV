import 'package:flutter_web/features/cart/domain/entities/cart.dart';

class CartModel extends cart {
  const CartModel(
      {super.id,
      required super.userId,
      required super.date,
      required super.products});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      date: json['date'].toString(),
      products: (json['products'] as List)
          .map((item) => cartItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    List s = [];
    products.forEach((item) {
      s.add(cartItemModel(productId: item.productId, quantity: item.quantity)
          .toJson());
    });
    return {'id': id, 'userId': userId, 'date': date, 'products': s};
  }
}

class cartItemModel extends cartitem {
  cartItemModel({required super.productId, required super.quantity});

  factory cartItemModel.fromJson(Map<String, dynamic> json) {
    return cartItemModel(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'quantity': quantity};
  }
}
