import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/reviews/domain/entities/review.dart';

abstract class ReviewsRepository {
  Future<Either<Failure, List<Review>>> getAllReveiws(
      {required String productId});
  Future<Either<Failure, Review>> getBestReview({required productId});
}
