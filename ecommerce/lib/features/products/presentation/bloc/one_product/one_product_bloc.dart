import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/core/strings/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/usecases/check_product_is_liked.dart';
import 'package:ecommernce/features/products/domain/usecases/get_favorites.dart';
import 'package:ecommernce/features/products/domain/usecases/get_populars.dart';
import 'package:ecommernce/features/products/domain/usecases/get_products_by_category.dart';
import 'package:ecommernce/features/products/domain/usecases/press_favorite_button.dart';
import 'package:ecommernce/features/products/presentation/bloc/category/category_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/category/category_state.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_state.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/one_product/one_product_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/one_product/one_product_state.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_state.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class OneProductBloc extends Bloc<OneProductEvent, OneProductState> {
  final PressFavoriteButtonUsecase pressFavoriteButton;
  final CheckProductIsLikedUsecase checkProductIsLikedUsecase;
  OneProductBloc({
    required this.pressFavoriteButton,
    required this.checkProductIsLikedUsecase,
  }) : super(FavoriteButtonInitial()) {
    on<OneProductEvent>((event, emit) async {
      if (event is CheckProductIsLikedEvent) {
        final failureOrPosts = await checkProductIsLikedUsecase(
            product: event.product, userId: event.userId);
        emit(
            _mapFailureOrPostsToState(failureOrPosts as Either<Failure, bool>));
      } else if (event is PressFavoriteButtonEvent) {
        //  emit(LoadingProductsByCategoryState());
        final failureOrPosts = await pressFavoriteButton(
            product: event.product, isLiked: event.isLiked);
        emit(
            _mapFailureOrPostsToState(failureOrPosts as Either<Failure, bool>));
      }
    });
  }

  OneProductState _mapFailureOrPostsToState(Either<Failure, bool> either) {
    return either.fold((failure) {
      print("fffff");
      return ErrorFavoriteButtonState(message: _mapFailureToMessage(failure));
    }, (isLiked) {
      //  print("yyyyyyy " + isLiked.toString());
      return FavoriteButtonState(isLiked: isLiked);
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
