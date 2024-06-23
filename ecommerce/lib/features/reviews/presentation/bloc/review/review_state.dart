//part of 'favorites_bloc.dart';
import 'package:ecommernce/features/reviews/domain/entities/review.dart';

abstract class ReviewsState {
  const ReviewsState();

  @override
  List<Object> get props => [];
}

class ReviewsInitial extends ReviewsState {}

class LoadingReviewsState extends ReviewsState {}

class LoadedReviewsState extends ReviewsState {
  final List<Review> allReviews;

  LoadedReviewsState({required this.allReviews});

  @override
  List<Object> get props => [allReviews];
}

class LoadedBestReviewState extends ReviewsState {
  final Review bestReview;

  LoadedBestReviewState({required this.bestReview});

  @override
  List<Object> get props => [bestReview];
}

class ErrorReviewsState extends ReviewsState {
  final String message;

  ErrorReviewsState({required this.message});

  @override
  List<Object> get props => [message];
}
