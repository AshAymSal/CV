import 'package:ecommernce/features/purchase/presentation/bloc/order/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState(items: Map()));

  void editItems(String key, String value) {
    if (value == '0') {
      state.items.remove(key);
      return;
    }
    state.items[key] = value;
    print(state.items);
  }
}
