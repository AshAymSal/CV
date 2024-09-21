// lib/presentation/blocs/product_state.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_web/features/auth/domain/entities/user.dart';
import 'package:flutter_web/features/products/domain/entities/product.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignout extends AuthState {}

class AuthSignin extends AuthState {
  final user u;

  const AuthSignin(this.u);

  @override
  List<Object?> get props => [u];
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
