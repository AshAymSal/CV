//part of 'favorites_bloc.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';

abstract class PopularsState {
  const PopularsState();

  @override
  List<Object> get props => [];
}

class PopularsInitial extends PopularsState {}

class LoadingPopularsState extends PopularsState {}

class LoadedPopularsState extends PopularsState {
  final List<Product> populars;

  LoadedPopularsState({required this.populars});

  @override
  List<Object> get props => [populars];
}

class ErrorPopularsState extends PopularsState {
  final String message;

  ErrorPopularsState({required this.message});

  @override
  List<Object> get props => [message];
}
