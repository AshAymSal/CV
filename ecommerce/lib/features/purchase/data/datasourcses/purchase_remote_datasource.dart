import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/purchase/data/models/purchase_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:http_auth/http_auth.dart';

abstract class PurchaseRemoteDataSource {
  Future<List<PurchaseModel>> getSales({required String userId});
}

class PurchaseRemoteDataSourceImpl implements PurchaseRemoteDataSource {
  PurchaseRemoteDataSourceImpl();

  @override
  Future<List<PurchaseModel>> getSales({required String userId}) async {
    List<PurchaseModel> sales = [];
    CollectionReference ref = FirebaseFirestore.instance.collection("products");
    QuerySnapshot ref2 = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("sales")
        .get();

    for (var elementt in ref2.docs) {
      String id = elementt["id"];
      String time = elementt["daytime"];
      String date = elementt["daydate"];
      List images = elementt["images"];
      String name = elementt["name"];
      String cost = elementt["cost"];

      String quantity = elementt["quantity"];
      Product p = Product(
        cost: cost,
        id: id,
        daydate: date,
        daytime: time,
        images: images,
        name: name,
      );
      PurchaseModel pur = PurchaseModel(p: p, quantity: quantity);
      sales.add(pur);
    }

    return sales;
  }
}
