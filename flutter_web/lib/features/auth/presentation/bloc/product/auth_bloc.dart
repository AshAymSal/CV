import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/core/strings/failures.dart';
import 'package:flutter_web/features/auth/domain/entities/user.dart';
import 'package:flutter_web/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_web/features/auth/presentation/bloc/product/auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  user? u;

  AuthBloc({
    required this.loginUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final u =
        await loginUseCase(username: event.username, password: event.password);
    emit(_mapFailureOrLogin(u));
  }

  AuthState _mapFailureOrLogin(Either<Failure, user> either) {
    return either.fold((failure) {
      return (AuthError(_mapFailureToMessage(failure)));
    }, (done) {
      u = done;
      return AuthSignin(
        done,
      );
    });
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    u = null;
    emit(AuthSignout());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
