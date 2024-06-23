import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/core/strings/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/usecases/get_favorites.dart';
import 'package:ecommernce/features/products/domain/usecases/get_populars.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_state.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_state.dart';
import 'package:ecommernce/features/reviews/domain/entities/review.dart';
import 'package:ecommernce/features/reviews/domain/usecases/get_all_reviews.dart';
import 'package:ecommernce/features/reviews/domain/usecases/get_best_review.dart';
import 'package:ecommernce/features/reviews/presentation/bloc/review/review_events.dart';
import 'package:ecommernce/features/reviews/presentation/bloc/review/review_state.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final GetAllReviewsUsecase getAllReviews;
  final GetBestReviewUsecase getBestreview;
  ReviewsBloc({
    required this.getAllReviews,
    required this.getBestreview,
  }) : super(ReviewsInitial()) {
    on<ReviewsEvent>((event, emit) async {
      if (event is GetAllReviewsEvent) {
        emit(LoadingReviewsState());

        final failureOrPosts = await getAllReviews(productId: event.productId);
        emit(_mapFailureOrAllReviewsToState(
            failureOrPosts as Either<Failure, List<Review>>));
      } else if (event is GetBestReviewEvent) {
        emit(LoadingReviewsState());

        final failureOrPosts = await getBestreview(productId: event.productId);
        emit(_mapFailureOrBestReviewToState(
            failureOrPosts as Either<Failure, Review>));
      }
    });
  }

  ReviewsState _mapFailureOrAllReviewsToState(
      Either<Failure, List<Review>> either) {
    return either.fold((failure) {
      print("fffff");
      return ErrorReviewsState(message: _mapFailureToMessage(failure));
    }, (allReviews) {
      print("yyyyyyy " + allReviews.length.toString());
      return LoadedReviewsState(allReviews: allReviews);
    });
  }

  ReviewsState _mapFailureOrBestReviewToState(Either<Failure, Review> either) {
    return either.fold((failure) {
      print("fffff");
      return ErrorReviewsState(message: _mapFailureToMessage(failure));
    }, (bestReview) {
      print("yyyyyyy " + bestReview.toString());
      return LoadedBestReviewState(
        bestReview: bestReview,
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
