import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/core/strings/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/usecases/get_favorites.dart';
import 'package:ecommernce/features/products/domain/usecases/get_populars.dart';
import 'package:ecommernce/features/products/domain/usecases/get_products_by_category.dart';
import 'package:ecommernce/features/products/presentation/bloc/category/category_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/category/category_state.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_state.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_state.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetProductsByCategoryUsecase getProductsByCategory;
  CategoryBloc({
    required this.getProductsByCategory,
  }) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is GetProductsByCategoryEvent) {
        emit(LoadingProductsByCategoryState());

        final failureOrPosts =
            await getProductsByCategory(category: event.category);
        emit(_mapFailureOrPostsToState(
            failureOrPosts as Either<Failure, List<Product>>));
      } else if (event is RefreshProductsByCategoryEvent) {
        emit(LoadingProductsByCategoryState());

        final failureOrPosts =
            await getProductsByCategory(category: event.category);
        emit(_mapFailureOrPostsToState(
            failureOrPosts as Either<Failure, List<Product>>));
      }
    });
  }

  CategoryState _mapFailureOrPostsToState(
      Either<Failure, List<Product>> either) {
    return either.fold((failure) {
      print("fffff");
      return ErrorProductsByCategoryState(
          message: _mapFailureToMessage(failure));
    }, (productsByCategory) {
      //print("yyyyyyy " + productsByCategory.length.toString());
      return LoadedProductsByCategoryState(
        productsByCategory: productsByCategory,
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
