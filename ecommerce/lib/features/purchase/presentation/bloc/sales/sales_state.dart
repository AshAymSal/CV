//part of 'favorites_bloc.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';

abstract class SalesState {
  const SalesState();

  @override
  List<Object> get props => [];
}

class SalesInitial extends SalesState {}

class LoadingSalesState extends SalesState {}

class LoadedSalesState extends SalesState {
  final List<Purchase> sales;

  LoadedSalesState({required this.sales});

  @override
  List<Object> get props => [sales];
}

class ErrorSalesState extends SalesState {
  final String message;

  ErrorSalesState({required this.message});

  @override
  List<Object> get props => [message];
}
