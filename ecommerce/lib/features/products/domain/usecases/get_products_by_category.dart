import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/repositories/product_repository.dart';

class GetProductsByCategoryUsecase {
  final ProductsRepository repository;

  GetProductsByCategoryUsecase({required this.repository});

  Future<Either<Failure, List<Product>>> call(
      {required String category}) async {
    print('GetProductsByCategoryUsecase');
    return await repository.getProductsByCategory(category: category);
  }
}
