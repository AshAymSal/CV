// lib/presentation/blocs/product_state.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_web/features/cart/domain/entities/cart.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class UserCartLoading extends CartState {}

class AddCartLoading extends CartState {}

class AddCartLoaded extends CartState {}

class ItemToCartLoading extends CartState {}

class ItemToCartLoaded extends CartState {}

class UserCartLoaded extends CartState {
  final List<cart> carts;

  const UserCartLoaded(this.carts);

  @override
  List<Object?> get props => [carts];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
