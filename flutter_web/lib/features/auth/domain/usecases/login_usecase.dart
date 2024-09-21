// lib/domain/usecases/add_product_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_web/features/products/domain/repositories/product_repository.dart';

import '../entities/user.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, user>> call(
      {required String username, required String password}) async {
    return await repository.login(password: password, username: username);
  }
}
