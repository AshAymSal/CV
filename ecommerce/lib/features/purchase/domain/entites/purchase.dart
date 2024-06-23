import 'package:ecommernce/features/products/domain/entities/product.dart';

class Purchase {
  Product? p;
  String? quantity;
  Map? detalis;

  Purchase({this.detalis, this.p, this.quantity});
}
