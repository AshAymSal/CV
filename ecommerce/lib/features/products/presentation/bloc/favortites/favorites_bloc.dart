import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/core/strings/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/usecases/get_favorites.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_state.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_events.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUsecase getAllFavorites;
  FavoritesBloc({
    required this.getAllFavorites,
  }) : super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) async {
      if (event is GetAllFavoritesEvent) {
        emit(LoadingFavoritesState());

        final failureOrPosts = await getAllFavorites(userId: event.userId);
        emit(_mapFailureOrPostsToState(
            failureOrPosts as Either<Failure, List<Product>>));
      } else if (event is RefreshFavoritesEvent) {
        emit(LoadingFavoritesState());

        final failureOrPosts = await getAllFavorites(userId: event.userId);
        emit(_mapFailureOrPostsToState(
            failureOrPosts as Either<Failure, List<Product>>));
      }
    });
  }

  FavoritesState _mapFailureOrPostsToState(
      Either<Failure, List<Product>> either) {
    return either.fold((failure) {
      print("fffff");
      return ErrorFavoritesState(message: _mapFailureToMessage(failure));
    }, (favorites) {
      print("yyyyyyy " + favorites.length.toString());
      return LoadedFavoritesState(
        favorites: favorites,
      );
    });
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
