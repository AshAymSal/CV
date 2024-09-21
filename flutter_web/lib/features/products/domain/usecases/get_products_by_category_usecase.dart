import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/products/domain/repositories/product_repository.dart';

import '../entities/product.dart';

class GetProductsByCategoryUsecase {
  final ProductsRepository repository;

  GetProductsByCategoryUsecase({required this.repository});

  Future<Either<Failure, List<Product>>> call(
      {required String category}) async {
    print('GetProductsByCategoryUsecase');
    return await repository.getProductsByCategory(category: category);
  }
}
