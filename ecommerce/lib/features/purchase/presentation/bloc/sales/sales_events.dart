//part of 'favorites_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class SalesEvent extends Equatable {
  const SalesEvent();

  @override
  List<Object> get props => [];
}

class GetSalesEvent extends SalesEvent {
  final String userId;

  GetSalesEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
