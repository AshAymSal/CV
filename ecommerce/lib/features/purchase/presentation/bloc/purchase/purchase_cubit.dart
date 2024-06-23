import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:ecommernce/core/strings/failures.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/usecases/get_products_by_category.dart';
import 'package:ecommernce/features/products/presentation/bloc/category/category_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/category/category_state.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/purchase/purchase_state.dart';
import 'package:ecommernce/features/purchase/presentation/pages/check_out_page.dart';
import 'package:ecommernce/features/purchase/presentation/widgets/check_out_page/one_item_quantity_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  PurchaseCubit() : super(PurchaseState(purchases: [], total: 0));

  void addToPurchase(Purchase p) {
    //final currentState = state as LoadedPurchasesState;
    var list = state.purchases;
    list.add(p);
    emit(PurchaseState(purchases: list, total: state.total));
  }

  void removeFromPurchase(Purchase p) {
//    final currentState = state as LoadedPurchasesState;
    var list = state.purchases;
    list.remove(p);
    emit(PurchaseState(purchases: list, total: state.total));
  }

  void addToTotal(int a) {
    //final currentState = state as PurchaseState;
    var total = state.total;
    total += a;
    emit(PurchaseState(purchases: state.purchases, total: total));
  }

  void minusFromTotal(int a) {
    //final currentState = state as LoadedPurchasesState;
    var total = state.total;
    total -= a;
    emit(PurchaseState(purchases: state.purchases, total: total));
  }

  void editQuantity(Purchase p, List<oneItemQuantity> wed) {
    //final currentState = state as LoadedPurchasesState;
    int n = 0;
    for (oneItemQuantity w in wed) {
      print(w.keyMap + " dddd" + w.isDeleted.toString());

      if (!w.isDeleted) {
        p.detalis![w.keyMap] = w.quantity;
        n += int.parse(w.quantity);
      } else {
        p.detalis!.remove(w.keyMap);
      }
    }

    if (n > int.parse(p.quantity!)) {
      state.total += (n - int.parse(p.quantity!)) * int.parse(p.p!.cost!);
    } else if (n < int.parse(p.quantity!)) {
      state.total -= (int.parse(p.quantity!) - n) * int.parse(p.p!.cost!);
    }
    if (p.detalis!.isEmpty) {
      removeFromPurchase(p);
      //return;
    } else {
      p.quantity = n.toString();
    }

    emit(PurchaseState(purchases: state.purchases, total: state.total));
  }

  void clearPurchase() {
    emit(PurchaseState(purchases: [], total: 0));
  }
}
