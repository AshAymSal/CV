//part of 'favorites_bloc.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';

abstract class FavoritesState {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class LoadingFavoritesState extends FavoritesState {}

class LoadedFavoritesState extends FavoritesState {
  final List<Product> favorites;

  LoadedFavoritesState({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

class ErrorFavoritesState extends FavoritesState {
  final String message;

  ErrorFavoritesState({required this.message});

  @override
  List<Object> get props => [message];
}
