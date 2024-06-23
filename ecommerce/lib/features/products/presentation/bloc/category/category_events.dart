import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetProductsByCategoryEvent extends CategoryEvent {
  final String category;

  GetProductsByCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}

class RefreshProductsByCategoryEvent extends CategoryEvent {
  final String category;

  RefreshProductsByCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}
