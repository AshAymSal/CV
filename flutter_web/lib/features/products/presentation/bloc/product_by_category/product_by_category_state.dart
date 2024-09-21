import 'package:equatable/equatable.dart';
import 'package:flutter_web/features/products/domain/entities/product.dart';

abstract class ProductByCategoryState extends Equatable {
  const ProductByCategoryState();

  @override
  List<Object?> get props => [];
}

class ProductByCategoryInitial extends ProductByCategoryState {}

class ProductByCategoryLoading extends ProductByCategoryState {}

class ProductByCategoryLoaded extends ProductByCategoryState {
  final List<Product> products;

  const ProductByCategoryLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductByCategoryError extends ProductByCategoryState {
  final String message;

  const ProductByCategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
