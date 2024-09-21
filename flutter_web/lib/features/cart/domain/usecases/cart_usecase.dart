// lib/domain/usecases/add_product_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_web/features/cart/domain/entities/cart.dart';
import 'package:flutter_web/features/cart/domain/repositories/cart_repository.dart';
import 'package:flutter_web/features/products/domain/repositories/product_repository.dart';

class GetUserCartsCase {
  final CartRepository repository;

  GetUserCartsCase(this.repository);

  Future<Either<Failure, List<cart>>> call(int id) async {
    return await repository.getUserCarts(id);
  }
}
