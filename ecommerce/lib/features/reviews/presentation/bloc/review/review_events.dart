//part of 'favorites_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object> get props => [];
}

class GetAllReviewsEvent extends ReviewsEvent {
  String productId;
  GetAllReviewsEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class GetBestReviewEvent extends ReviewsEvent {
  String productId;
  GetBestReviewEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
