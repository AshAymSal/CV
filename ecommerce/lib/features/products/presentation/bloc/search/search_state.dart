//part of 'favorites_bloc.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';

abstract class SearchState {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class LoadingSearchState extends SearchState {}

class LoadedSearchState extends SearchState {
  final List<Product> productsBySearch;

  LoadedSearchState({required this.productsBySearch});

  @override
  List<Object> get props => [productsBySearch];
}

class ErrorSearchState extends SearchState {
  final String message;

  ErrorSearchState({required this.message});

  @override
  List<Object> get props => [message];
}
