import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/core/strings/failures.dart';
import 'package:flutter_web/features/products/domain/usecases/get_categories_usecase.dart';
import 'package:flutter_web/features/products/presentation/bloc/category/category_events.dart';
import 'package:flutter_web/features/products/presentation/bloc/category/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  CategoryBloc({
    required this.getCategoriesUseCase,
  }) : super(CategoryInitial()) {
    on<FetchCategories>(_onFetchCategories);
  }

  void _onFetchCategories(
      FetchCategories event, Emitter<CategoryState> emit) async {
    emit(CategoriesLoading());
    final categories = await getCategoriesUseCase();
    emit(_mapFailureOrAllCategories(categories));
  }

  CategoryState _mapFailureOrAllCategories(Either<Failure, List> either) {
    return either.fold((failure) {
      return CategoryError(_mapFailureToMessage(failure));
    }, (allCategories) {
      return CategoriesLoaded(
        allCategories,
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
