import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/repositories/product_repository.dart';
import 'package:ecommernce/features/reviews/domain/entities/review.dart';
import 'package:ecommernce/features/reviews/domain/repositories/review_reposaitory.dart';

class GetBestReviewUsecase {
  final ReviewsRepository repository;

  GetBestReviewUsecase({required this.repository});

  Future<Either<Failure, Review>> call({required productId}) async {
    print('GetBestReviewUsecase');
    return await repository.getBestReview(productId: productId);
  }
}
