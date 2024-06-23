import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/repositories/product_repository.dart';

class CheckProductIsLikedUsecase {
  final ProductsRepository repository;

  CheckProductIsLikedUsecase({required this.repository});

  Future<Either<Failure, bool>> call(
      {required String userId, required Product product}) async {
    print('CheckProductIsLikedUsecase');
    return await repository.checkProductIsLiked(
        userId: userId, product: product);
  }
}
