//part of 'favorites_bloc.dart';

import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

abstract class OneProductEvent extends Equatable {
  const OneProductEvent();

  @override
  List<Object> get props => [];
}

class PressFavoriteButtonEvent extends OneProductEvent {
  final bool isLiked;
  final Product product;

  PressFavoriteButtonEvent({required this.product, required this.isLiked});

  @override
  List<Object> get props => [product, isLiked];
}

class CheckProductIsLikedEvent extends OneProductEvent {
  final Product product;
  final String userId;

  CheckProductIsLikedEvent({required this.userId, required this.product});

  @override
  List<Object> get props => [product, userId];
}
//class RefreshFavoritesEvent extends OneProduct {}
