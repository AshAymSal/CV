import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getPopular();
  Future<Either<Failure, List<Product>>> getFavorites({required String userId});
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      {required String category});
  Future<Either<Failure, List<Product>>> getProductsBySearch(
      {required String searchText});
  Future<Either<Failure, Unit>> removeFromFavoritesAsId(int id);
  Future<Either<Failure, bool>> pressFavoriteButton(
      {required Product product, required bool isLiked});
  Future<Either<Failure, bool>> checkProductIsLiked(
      {required String userId, required Product product});
  //Future<void> deletePost(int id);
  //Future<void> updatePost(Product product);
}
