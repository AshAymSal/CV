// lib/presentation/blocs/product_state.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_web/features/products/domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  const ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductByIdLoaded extends ProductState {
  final Product product;

  const ProductByIdLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductAdded extends ProductState {
  final String done;

  const ProductAdded(this.done);

  @override
  List<Object?> get props => [done];
}

class ProductUpdated extends ProductState {
  final String done;

  const ProductUpdated(this.done);

  @override
  List<Object?> get props => [done];
}

class ProductDeleted extends ProductState {
  final String done;

  const ProductDeleted(this.done);

  @override
  List<Object?> get props => [done];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
