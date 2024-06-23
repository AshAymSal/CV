//part of 'favorites_bloc.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';

abstract class OneProductState {
  const OneProductState();

  @override
  List<Object> get props => [];
}

class FavoriteButtonInitial extends OneProductState {}

class FavoriteButtonState extends OneProductState {
  final bool isLiked;

  FavoriteButtonState({required this.isLiked});

  @override
  List<Object> get props => [isLiked];
}

class ErrorFavoriteButtonState extends OneProductState {
  final String message;

  ErrorFavoriteButtonState({required this.message});

  @override
  List<Object> get props => [message];
}
