//part of 'favorites_bloc.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';

abstract class CategoryState {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class LoadingProductsByCategoryState extends CategoryState {}

class LoadedProductsByCategoryState extends CategoryState {
  final List<Product> productsByCategory;

  LoadedProductsByCategoryState({required this.productsByCategory});

  @override
  List<Object> get props => [productsByCategory];
}

class ErrorProductsByCategoryState extends CategoryState {
  final String message;

  ErrorProductsByCategoryState({required this.message});

  @override
  List<Object> get props => [message];
}
