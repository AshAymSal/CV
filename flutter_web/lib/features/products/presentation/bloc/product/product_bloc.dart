import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/core/strings/failures.dart';
import 'package:flutter_web/features/products/domain/entities/product.dart';
import 'package:flutter_web/features/products/domain/usecases/add_product_usecase.dart';
import 'package:flutter_web/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:flutter_web/features/products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:flutter_web/features/products/domain/usecases/get_products_usecase.dart';
import 'package:flutter_web/features/products/domain/usecases/update_product_usecase.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductByIdUseCase getProductByIdUseCase;
  final AddProductUseCase addProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ProductBloc({
    required this.getProductsUseCase,
    required this.getProductByIdUseCase,
    required this.addProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
  }) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<FetchProductById>(_onFetchProductById);
    on<AddProduct>(_onAddProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  void _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final products = await getProductsUseCase();
    emit(_mapFailureOrAllProdcuts(products));
  }

  void _onFetchProductById(
      FetchProductById event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final product = await getProductByIdUseCase(event.id);
    emit(_mapFailureOrProductsById(product));
  }

  void _onAddProduct(AddProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    final done = await addProductUseCase(event.product);
    emit(_mapFailureOrAddProduct(done as Either<Failure, String>));
  }

  void _onUpdateProduct(UpdateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    final done = await updateProductUseCase(event.product);
    emit(_mapFailureOrEditProduct(done as Either<Failure, String>));
  }

  void _onDeleteProduct(DeleteProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final done = await deleteProductUseCase(event.id);
    emit(_mapFailureOrDeleteProduct(done as Either<Failure, String>));
  }

  ProductState _mapFailureOrAllProdcuts(Either<Failure, List<Product>> either) {
    return either.fold((failure) {
      return ProductError(_mapFailureToMessage(failure));
    }, (allProducts) {
      return ProductLoaded(
        allProducts,
      );
    });
  }

  ProductState _mapFailureOrProductsById(Either<Failure, Product> either) {
    return either.fold((failure) {
      return ProductError(_mapFailureToMessage(failure));
    }, (prodctById) {
      return ProductByIdLoaded(
        prodctById,
      );
    });
  }

  ProductState _mapFailureOrAddProduct(Either<Failure, String> either) {
    return either.fold((failure) {
      return ProductError(_mapFailureToMessage(failure));
    }, (done) {
      return ProductAdded(
        done,
      );
    });
  }

  ProductState _mapFailureOrEditProduct(Either<Failure, String> either) {
    return either.fold((failure) {
      return ProductError(_mapFailureToMessage(failure));
    }, (done) {
      return ProductUpdated(
        done,
      );
    });
  }

  ProductState _mapFailureOrDeleteProduct(Either<Failure, String> either) {
    return either.fold((failure) {
      return ProductError(_mapFailureToMessage(failure));
    }, (done) {
      return ProductDeleted(
        done,
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
