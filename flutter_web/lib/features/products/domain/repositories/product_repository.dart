import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/products/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();

  Future<Either<Failure, List<Product>>> getProductsByCategory(
      {required String category});

  Future<Either<Failure, Product>> getProductById(int id);

  Future<Either<Failure, List>> getCategories();

  Future<Either<Failure, Product>> addProduct(Product pro);

  Future<Either<Failure, void>> updateProduct(Product pro);

  Future<Either<Failure, void>> deleteProduct(int id);
}
