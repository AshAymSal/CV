import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/repositories/product_repository.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:ecommernce/features/purchase/domain/repositories/purchase_repository.dart';

class GetSalesUsecase {
  final PurchaseRepository repository;

  GetSalesUsecase({required this.repository});

  Future<Either<Failure, List<Purchase>>> call({required String userId}) async {
    print('GetFavoritesUsecase');
    return await repository.getSales(userId: userId);
  }
}
