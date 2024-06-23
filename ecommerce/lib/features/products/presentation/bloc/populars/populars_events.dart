//part of 'favorites_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class PopularsEvent extends Equatable {
  const PopularsEvent();

  @override
  List<Object> get props => [];
}

class GetAllPopularsEvent extends PopularsEvent {}

class RefreshPopularsEvent extends PopularsEvent {}
