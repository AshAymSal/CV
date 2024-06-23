import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/repositories/product_repository.dart';
import 'package:ecommernce/features/reviews/domain/entities/review.dart';
import 'package:ecommernce/features/reviews/domain/repositories/review_reposaitory.dart';

class GetAllReviewsUsecase {
  final ReviewsRepository repository;

  GetAllReviewsUsecase({required this.repository});

  Future<Either<Failure, List<Review>>> call(
      {required String productId}) async {
    print('GetAllReviewsUsecase');
    return await repository.getAllReveiws(productId: productId);
  }
}
