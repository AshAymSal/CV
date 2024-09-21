import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/auth/domain/entities/user.dart';
import 'package:flutter_web/features/cart/domain/entities/cart.dart';
import 'package:flutter_web/features/products/domain/entities/product.dart';

abstract class CartRepository {
  Future<Either<Failure, List<cart>>> getUserCarts(int id);
  Future<Either<Failure, void>> addCart({required cart c});
}
