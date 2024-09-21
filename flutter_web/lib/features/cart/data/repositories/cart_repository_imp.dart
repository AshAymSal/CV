import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/exceptions.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:flutter_web/features/cart/data/models/cart_model.dart';
import 'package:flutter_web/features/cart/domain/entities/cart.dart';
import 'package:flutter_web/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  CartRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> addCart({required cart c}) async {
    //   cart cc = CartModel(id: 1, userId: 1, date: "date", products: []);
    // CartModel cm = cart(userId: 1, date: "", products: []) as CartModel;
    try {
      final addCart = await remoteDataSource.addCart(CartModel(
        date: c.date,
        products: c.products,
        userId: c.userId,
      ));
      return Right(addCart);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<cart>>> getUserCarts(int id) async {
    try {
      final getCart = await remoteDataSource.getUserCarts(id);
      print(getCart);
      return Right(getCart);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
