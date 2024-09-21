// lib/domain/usecases/get_product_by_id_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/products/domain/repositories/product_repository.dart';
import '../entities/product.dart';

class GetProductByIdUseCase {
  final ProductsRepository repository;

  GetProductByIdUseCase(this.repository);

  Future<Either<Failure, Product>> call(int id) async {
    return await repository.getProductById(id);
  }
}
