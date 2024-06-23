import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/repositories/product_repository.dart';

class GetPopularsUsecase {
  final ProductsRepository repository;

  GetPopularsUsecase({required this.repository});

  Future<Either<Failure, List<Product>>> call() async {
    print('GetFavoritesUsecase');
    return await repository.getPopular();
  }
}
