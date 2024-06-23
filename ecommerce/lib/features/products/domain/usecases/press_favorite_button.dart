import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/repositories/product_repository.dart';

class PressFavoriteButtonUsecase {
  final ProductsRepository repository;

  PressFavoriteButtonUsecase({required this.repository});

  Future<Either<Failure, bool>> call(
      {required Product product, required bool isLiked}) async {
    print('PressFavoriteButtonUsecase');
    return await repository.pressFavoriteButton(
        product: product, isLiked: isLiked);
  }
}
