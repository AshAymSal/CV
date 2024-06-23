import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/repositories/product_repository.dart';

class GetProductsBySearchUsecase {
  final ProductsRepository repository;

  GetProductsBySearchUsecase({required this.repository});

  Future<Either<Failure, List<Product>>> call(
      {required String searchText}) async {
    print('GetProductsByCategoryUsecase');
    return await repository.getProductsBySearch(searchText: searchText);
  }
}
