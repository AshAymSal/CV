//part of 'favorites_bloc.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:flutter/material.dart';

class PurchaseState {
  List<Purchase> purchases;
  int total;
  PurchaseState({required this.purchases, required this.total});

  @override
  List<Object> get props => [];
}

/*class PurchasesInitial extends PurchaseState {
  List<Purchase> purchases;
  int total;

  PurchasesInitial({required this.purchases, required this.total});
}

//class LoadingPurchasesState extends PurchaseState {}

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