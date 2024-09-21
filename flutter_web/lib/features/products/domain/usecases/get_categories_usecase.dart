// lib/domain/usecases/get_categories_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/products/domain/repositories/product_repository.dart';

class GetCategoriesUseCase {
  final ProductsRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List>> call() async {
    print("caaaaatu");

    return await repository.getCategories();
  }
}
