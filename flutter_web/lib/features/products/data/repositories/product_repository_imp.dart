import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/exceptions.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/features/products/data/datasources/products_remote_datasource.dart';
import 'package:flutter_web/features/products/data/models/product_model.dart';
import 'package:flutter_web/features/products/domain/entities/product.dart';
import 'package:flutter_web/features/products/domain/repositories/product_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  ProductsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      {required String category}) async {
    try {
      final remoteProductsByCategory =
          await remoteDataSource.fetchProductsByCategory(category);
      //  print(remoteProductsByCategory);
      return Right(remoteProductsByCategory);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final remoteAllProducts = await remoteDataSource.fetchProducts();
      return Right(remoteAllProducts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> addProduct(Product pro) async {
    try {
      final AddProduct = await remoteDataSource.addProduct(pro as ProductModel);
      return Right(AddProduct);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      final remoteAllProducts = await remoteDataSource.deleteProduct(id);
      return Right(remoteAllProducts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List>> getCategories() async {
    try {
      final remoteAllProducts = await remoteDataSource.fetchCategories();
      return Right(remoteAllProducts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product pro) async {
    throw UnimplementedError();
  }
}
