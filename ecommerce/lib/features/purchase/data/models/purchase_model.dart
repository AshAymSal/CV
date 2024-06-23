import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';

class PurchaseModel extends Purchase {
  Product? p;
  String? quantity;
  Map? detalis;

  PurchaseModel({this.detalis, this.p, this.quantity});

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      p: json['p'],
      quantity: json['quantity'],
      detalis: json['detalis'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'p': p,
      'quantity': quantity,
      'detalis': detalis,
    };
  }
}
