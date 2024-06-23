import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';

abstract class PurchaseRepository {
  Future<Either<Failure, List<Purchase>>> getSales({required String userId});
}
