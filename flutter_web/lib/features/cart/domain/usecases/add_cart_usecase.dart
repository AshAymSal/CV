import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_web/features/cart/domain/entities/cart.dart';
import 'package:flutter_web/features/cart/domain/repositories/cart_repository.dart';
import 'package:flutter_web/features/products/domain/repositories/product_repository.dart';

class AddCartUsecase {
  final CartRepository repository;

  AddCartUsecase(this.repository);

  Future<Either<Failure, void>> call(cart c) async {
    return await repository.addCart(c: c);
  }
}
