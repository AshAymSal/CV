import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/core/strings/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/usecases/get_favorites.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_state.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_events.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:ecommernce/features/purchase/domain/usecases/get_sales.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/sales/sales_events.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/sales/sales_state.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  final GetSalesUsecase getSales;
  SalesBloc({
    required this.getSales,
  }) : super(SalesInitial()) {
    on<SalesEvent>((event, emit) async {
      if (event is GetSalesEvent) {
        emit(LoadingSalesState());

        final failureOrPosts = await getSales(userId: event.userId);
        emit(_mapFailureOrSalesToState(
            failureOrPosts as Either<Failure, List<Purchase>>));
      }
    });
  }

  SalesState _mapFailureOrSalesToState(Either<Failure, List<Purchase>> either) {
    return either.fold((failure) {
      print("fffff");
      return ErrorSalesState(message: _mapFailureToMessage(failure));
    }, (sales) {
      print("yyyyyyy " + sales.length.toString());
      return LoadedSalesState(
        sales: sales,
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
