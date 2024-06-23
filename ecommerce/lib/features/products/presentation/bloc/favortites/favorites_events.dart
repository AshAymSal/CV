//part of 'favorites_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class GetAllFavoritesEvent extends FavoritesEvent {
  final String userId;

  GetAllFavoritesEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class RefreshFavoritesEvent extends FavoritesEvent {
  final String userId;

  RefreshFavoritesEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
