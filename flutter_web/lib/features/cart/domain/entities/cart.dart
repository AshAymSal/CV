import 'package:equatable/equatable.dart';

// lib/product.dart

class cart extends Equatable {
  final int? id;
  final int userId;
  final String date;
  final List<cartitem> products;

  const cart({
    this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  @override
  List<Object?> get props => [id, date, userId, products];
}

class cartitem extends Equatable {
  int productId;
  int quantity;

  cartitem({required this.productId, required this.quantity});

  @override
  // TODO: implement props
  List<Object?> get props => [productId, quantity];
}
