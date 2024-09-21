import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/exceptions.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/auth/data/datasources/Auth_remote_datasource.dart';
import 'package:flutter_web/features/auth/domain/entities/user.dart';
import 'package:flutter_web/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, user>> login(
      {required String username, required String password}) async {
    try {
      final login =
          await remoteDataSource.login(password: password, username: username);
      print(login);
      return Right(login);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
