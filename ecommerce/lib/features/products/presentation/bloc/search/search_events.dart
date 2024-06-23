//part of 'favorites_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetProductsBySearchEvent extends SearchEvent {
  final String searchText;

  GetProductsBySearchEvent({required this.searchText});

  @override
  List<Object> get props => [searchText];
}

class RefreshProductsBySearchEvent extends SearchEvent {}
