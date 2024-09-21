import 'package:equatable/equatable.dart';

abstract class ProductByCategoryEvent extends Equatable {
  const ProductByCategoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductsByCategory extends ProductByCategoryEvent {
  final String category;

  const FetchProductsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}
