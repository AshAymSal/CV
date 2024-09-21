import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/core/strings/failures.dart';
import 'package:flutter_web/features/products/domain/entities/product.dart';
import 'package:flutter_web/features/products/domain/usecases/get_products_by_category_usecase.dart';
import 'package:flutter_web/features/products/presentation/bloc/product_by_category/product_by_category_events.dart';
import 'package:flutter_web/features/products/presentation/bloc/product_by_category/product_by_category_state.dart';

class ProductByCategoryBloc
    extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
  final GetProductsByCategoryUsecase getProductsByCategoryUseCase;

  ProductByCategoryBloc({
    required this.getProductsByCategoryUseCase,
  }) : super(ProductByCategoryInitial()) {
    on<FetchProductsByCategory>(_onFetchProductsByCategory);
  }

  void _onFetchProductsByCategory(FetchProductsByCategory event,
      Emitter<ProductByCategoryState> emit) async {
    emit(ProductByCategoryLoading());
    final products =
        await getProductsByCategoryUseCase(category: event.category);
    // print(products);
    emit(_mapFailureOrgetProductsByCategory(products));
  }

  ProductByCategoryState _mapFailureOrgetProductsByCategory(
      Either<Failure, List<Product>> either) {
    return either.fold((failure) {
      return ProductByCategoryError(_mapFailureToMessage(failure));
    }, (allProductsByCategory) {
      //  print(allProductsByCategory);
      return ProductByCategoryLoaded(
        allProductsByCategory,
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
