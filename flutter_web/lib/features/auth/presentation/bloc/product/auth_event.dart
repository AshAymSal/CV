// lib/presentation/blocs/product_event.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_web/features/auth/domain/entities/user.dart';
import 'package:flutter_web/features/products/domain/entities/product.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthEvent extends AuthEvent {
  const CheckAuthEvent();

  @override
  List<Object?> get props => [];
}
