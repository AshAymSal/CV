import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:intl/intl.dart';

class firebaseServices {
  firebaseServices();

  void increaseTimes(List<Purchase> pur) {
    for (var p in pur) {
      int purTimes = int.parse(p.quantity!);

      FirebaseFirestore.instance
          .collection("products")
          .doc(p.p!.id!)
          .get()
          .then((value) {
        var data = value.data() as Map;
        int oldTimes = int.parse(data['times']);
        int newTimes = purTimes += oldTimes;
        FirebaseFirestore.instance
            .collection("products")
            .doc(p.p!.id!)
            .update({'times': newTimes.toString()});
      });
    }
  }

  void addToSales(String id, List pur) {
    String daydate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String dattime = DateFormat("HH:mm:ss").format(DateTime.now());
    for (Purchase r in pur) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection('sales')
          .add({
        "id": r.p!.id,
        "name": r.p!.name,
        "cost": r.p!.cost,
        "quantity": r.quantity,
        "image": r.p!.images![0],
        "daytime": dattime,
        "daydate": daydate,
      });
    }
  }

  void addToProfits(List<Purchase> pur) {
    int total = 0;
    for (var p in pur) {
      int purCost = int.parse(p.p!.cost!) * int.parse(p.quantity!);
      total += purCost;
      print("${p.p!.name!} " + purCost.toString());
      // print("${p.p!.name!}  newProfits  " + newProfits.toString());
    }

    CollectionReference ref3 = FirebaseFirestore.instance.collection("profits");
    ref3.get().then((value) {
      final prof = value.docs[0]["total"];
      final profid = value.docs[0]["id"];

      int curprof = int.parse(prof);
      print("curprof  " + curprof.toString());
      int plusprof = curprof + total;
      print("plusprof  " + plusprof.toString());
      ref3.doc(profid).update({"total": plusprof.toString()});
    });
  }
}
