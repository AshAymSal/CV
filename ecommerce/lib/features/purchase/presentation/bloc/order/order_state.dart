//part of 'favorites_bloc.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:flutter/material.dart';

class OrderState {
  Map<String, String> items = Map();
  OrderState({required this.items});

  @override
  List<Object> get props => [];
}

/*class OrderssInitial extends OrderState {
  Map<String, String> items = Map();

  OrderssInitial({required this.items});
}

class LoadedPurchasesState extends PurchaseState {
  List<Purchase> purchases;
  int total;

  LoadedPurchasesState({required this.purchases, required this.total});

  @override
  List<Object> get props => [purchases];
}

class ErrorProductsByCategoryState extends PurchaseState {
  final String message;

  ErrorProductsByCategoryState({required this.message});

  @override
  List<Object> get props => [message];
}
*/