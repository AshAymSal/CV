// lib/presentation/blocs/product_event.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_web/features/cart/domain/entities/cart.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class GetUserCartsEvent extends CartEvent {
  int id;
  GetUserCartsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddItemsToCartEvent extends CartEvent {
  cartitem ci;
  AddItemsToCartEvent(this.ci);

  @override
  List<Object?> get props => [ci];
}

class AddCartEvent extends CartEvent {
  cart c;
  AddCartEvent(this.c);

  @override
  List<Object?> get props => [c];
}
