import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_web/core/errors/failures.dart';
import 'package:flutter_web/core/strings/failures.dart';
import 'package:flutter_web/features/cart/domain/entities/cart.dart';
import 'package:flutter_web/features/cart/domain/usecases/add_cart_usecase.dart';
import 'package:flutter_web/features/cart/domain/usecases/cart_usecase.dart';
import 'package:flutter_web/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:flutter_web/features/cart/presentation/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetUserCartsCase getUserUseCase;
  final AddCartUsecase addCartUseCase;
  List<cartitem> cartItems = [];

  CartBloc({
    required this.addCartUseCase,
    required this.getUserUseCase,
  }) : super(CartInitial()) {
    on<GetUserCartsEvent>(_onGetUserCarts);
    on<AddItemsToCartEvent>(_addItemsToCart);
    on<AddCartEvent>(_addCart);
    // on<LogoutEvent>(_onLogout);
  }

  void _addCart(AddCartEvent event, Emitter<CartState> emit) async {
    emit(AddCartLoading());
    final u = await addCartUseCase(event.c);

    emit(_mapFailureOrAddCart(u));
  }

  void _addItemsToCart(AddItemsToCartEvent event, Emitter<CartState> emit) {
    emit(ItemToCartLoading());
    cartItems.add(event.ci);
    print(cartItems);

    emit(ItemToCartLoaded());
  }

  void _onGetUserCarts(GetUserCartsEvent event, Emitter<CartState> emit) async {
    emit(UserCartLoading());
    final u = await getUserUseCase(event.id);
    emit(_mapFailureOrGetUserCarts(u));
  }

  CartState _mapFailureOrGetUserCarts(Either<Failure, List<cart>> either) {
    return either.fold((failure) {
      return (CartError(_mapFailureToMessage(failure)));
    }, (done) {
      return UserCartLoaded(
        done,
      );
    });
  }

  CartState _mapFailureOrAddCart(Either<Failure, void> either) {
    return either.fold((failure) {
      return (CartError(_mapFailureToMessage(failure)));
    }, (done) {
      return AddCartLoaded();
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
