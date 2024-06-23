import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/exceptions.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/core/network/network_info.dart';
import 'package:ecommernce/features/products/data/datasources/products_local_datasource.dart';
import 'package:ecommernce/features/products/data/datasources/products_remote_datasource.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/repositories/product_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getFavorites(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFavorites =
            await remoteDataSource.getFavorites(userId: userId);
        //print('getFavorites remote' + remoteFavorites.length.toString());
        // localDataSource.cacheFavorites(remotePosts);
        return Right(remoteFavorites);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedFavorites();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getPopular() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePopulars = await remoteDataSource.getPopular();
        print('getPopulars remote' + remotePopulars.length.toString());
        // localDataSource.cacheFavorites(remotePosts);
        return Right(remotePopulars);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedFavorites();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromFavoritesAsId(int id) {
    // TODO: implement removeFromFavoritesAsId
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      {required String category}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProductsByCategory =
            await remoteDataSource.getProductsByCategory(category: category);
        // print('getPopulars remote' + remoteProductsByCategory.length.toString());
        // localDataSource.cacheFavorites(remotePosts);
        return Right(remoteProductsByCategory);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedFavorites();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> pressFavoriteButton(
      {required Product product, required bool isLiked}) async {
    if (await networkInfo.isConnected) {
      try {
        final press = await remoteDataSource.pressFavoriteButton(
            product: product,
            isLiked: isLiked,
            userId: FirebaseAuth.instance.currentUser!.email!);
        //print('getPopulars remote' + remotePopulars.length.toString());
        // localDataSource.cacheFavorites(remotePosts);
        return Right(press);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      print("not connected");
      return Right(false);
    }
  }

  @override
  Future<Either<Failure, bool>> checkProductIsLiked(
      {required String userId, required Product product}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteIsLiked = await remoteDataSource.checkProductIsLiked(
            product: product, userId: userId);
        //print('getPopulars remote' + remotePopulars.length.toString());
        // localDataSource.cacheFavorites(remotePosts);
        return Right(remoteIsLiked);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      print("not connected");
      return Right(false);
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsBySearch(
      {required String searchText}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProductsByCategory =
            await remoteDataSource.getProductsBySearch(searchText: searchText);
        // print('getPopulars remote' + remoteProductsByCategory.length.toString());
        // localDataSource.cacheFavorites(remotePosts);
        return Right(remoteProductsByCategory);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      print("not connected");
      return Right([]);
    }
  }
}
