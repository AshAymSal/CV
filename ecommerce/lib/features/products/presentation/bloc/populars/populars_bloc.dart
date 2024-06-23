import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/core/strings/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/usecases/get_favorites.dart';
import 'package:ecommernce/features/products/domain/usecases/get_populars.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_state.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_state.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PopularsBloc extends Bloc<PopularsEvent, PopularsState> {
  final GetPopularsUsecase getPopulars;
  PopularsBloc({
    required this.getPopulars,
  }) : super(PopularsInitial()) {
    on<PopularsEvent>((event, emit) async {
      if (event is GetAllPopularsEvent) {
        emit(LoadingPopularsState());

        final failureOrPosts = await getPopulars();
        emit(_mapFailureOrPostsToState(
            failureOrPosts as Either<Failure, List<Product>>));
      } else if (event is RefreshPopularsEvent) {
        emit(LoadingPopularsState());

        final failureOrPosts = await getPopulars();
        emit(_mapFailureOrPostsToState(
            failureOrPosts as Either<Failure, List<Product>>));
      }
    });
  }

  PopularsState _mapFailureOrPostsToState(
      Either<Failure, List<Product>> either) {
    return either.fold((failure) {
      print("fffff");
      return ErrorPopularsState(message: _mapFailureToMessage(failure));
    }, (populars) {
      print("yyyyyyy " + populars.length.toString());
      return LoadedPopularsState(
        populars: populars,
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
