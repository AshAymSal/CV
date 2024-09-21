import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/auth/domain/entities/user.dart';
import 'package:flutter_web/features/products/domain/entities/product.dart';

abstract class AuthRepository {
  Future<Either<Failure, user>> login(
      {required String username, required String password});
}
