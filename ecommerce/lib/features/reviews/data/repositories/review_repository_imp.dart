import 'package:ecommernce/core/errors/exceptions.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/network/network_info.dart';
import 'package:ecommernce/features/reviews/data/datasources/reviews_remote_datasource.dart';
import 'package:ecommernce/features/reviews/domain/entities/review.dart';
import 'package:ecommernce/features/reviews/domain/repositories/review_reposaitory.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsRemoteDataSourceImpl remoteDataSource;
  //final ProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  ReviewsRepositoryImpl({
    required this.remoteDataSource,
    //required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Review>>> getAllReveiws(
      {required String productId}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteReviews =
            await remoteDataSource.getAllReviews(productId: productId);
        print('getAllReveiws remote' + remoteReviews.length.toString());
        // localDataSource.cacheFavorites(remotePosts);
        return Right(remoteReviews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Right([]);
    }
  }

  @override
  Future<Either<Failure, Review>> getBestReview({required productId}) async {
    try {
      final remoteBestReview =
          await remoteDataSource.getBestReview(productId: productId);
      print('remoteBestReview remote' + remoteBestReview.toString());
      // localDataSource.cacheFavorites(remotePosts);
      return Right(remoteBestReview);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
