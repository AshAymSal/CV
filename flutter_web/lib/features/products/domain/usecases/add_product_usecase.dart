// lib/domain/usecases/add_product_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/products/domain/repositories/product_repository.dart';

import '../entities/product.dart';

class AddProductUseCase {
  final ProductsRepository repository;

  AddProductUseCase(this.repository);

  Future<Either<Failure, Product>> call(Product product) async {
    return await repository.addProduct(product);
  }
}
