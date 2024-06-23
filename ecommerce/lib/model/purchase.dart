import 'package:ecommernce/features/products/data/models/product_model.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/model/product.dart';

class purchase {
  Product? p;
  String? quantity;
  Map? dtalis;

  purchase({this.dtalis, this.p, this.quantity});
}
