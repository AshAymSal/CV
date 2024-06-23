import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/core/strings/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/usecases/get_favorites.dart';
import 'package:ecommernce/features/products/domain/usecases/get_populars.dart';
import 'package:ecommernce/features/products/domain/usecases/get_products_by_search.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_state.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_state.dart';
import 'package:ecommernce/features/products/presentation/bloc/search/search_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/search/search_state.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetProductsBySearchUsecase getProductsBySearch;
  SearchBloc({
    required this.getProductsBySearch,
  }) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is GetProductsBySearchEvent) {
        emit(LoadingSearchState());

        final failureOrPosts =
            await getProductsBySearch(searchText: event.searchText);
        emit(_mapFailureOrPostsToState(
            failureOrPosts as Either<Failure, List<Product>>));
      }
    });
  }

  SearchState _mapFailureOrPostsToState(Either<Failure, List<Product>> either) {
    return either.fold((failure) {
      print("fffff");
      return ErrorSearchState(message: _mapFailureToMessage(failure));
    }, (productsBySearch) {
      print("yyyyyyy " + productsBySearch.length.toString());
      return LoadedSearchState(
        productsBySearch: productsBySearch,
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
