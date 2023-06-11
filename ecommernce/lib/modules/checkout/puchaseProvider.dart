import 'package:ecommernce/model/purchase.dart';
import 'package:ecommernce/modules/checkout/transaction.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class purchaseProvider extends ChangeNotifier {
  List<purchase> purchases = [];
  int total = 0;

  static purchaseProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<purchaseProvider>();
  }

  static purchaseProvider getRead(BuildContext context) {
    //print("read");
    return context.read<purchaseProvider>();
  }

  List getPurchase() {
    return purchases;
  }

  void addToPurchase(purchase p) {
    purchases.add(p);
  }

  void removeItem(purchase p) {
    purchases.remove(p);
    notifyListeners();
  }

  addToTotal(int a) {
    total += a;
    notifyListeners();
  }

  minusFromTotal(int a) {
    total -= a;
    notifyListeners();
  }

  editQuantity(purchase p, List wed) {
    int n = 0;
    for (oneItemQuantity w in wed) {
      print(w.keyMap + " dddd" + w.isDeleted.toString());

      if (!w.isDeleted) {
        p.dtalis![w.keyMap] = w.quantity;
        n += int.parse(w.quantity);
      } else {
        p.dtalis!.remove(w.keyMap);
      }
    }

    if (n > int.parse(p.quantity!)) {
      total += (n - int.parse(p.quantity!)) * int.parse(p.p!.cost!);
    } else if (n < int.parse(p.quantity!)) {
      total -= (int.parse(p.quantity!) - n) * int.parse(p.p!.cost!);
    }
    if (p.dtalis!.isEmpty) {
      removeItem(p);
      //return;
    } else {
      p.quantity = n.toString();
    }

    notifyListeners();
  }

  clearPurchase() {
    purchases.clear();
    total = 0;
    notifyListeners();
  }
}
