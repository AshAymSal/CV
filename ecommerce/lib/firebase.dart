import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:ecommernce/model/product.dart';
import 'package:ecommernce/model/purchase.dart';
import 'package:ecommernce/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';

class firebase extends ChangeNotifier {
  List<product> sales = [];
  List<product> allProducts = [];
  List<user> allUsers = [];

  static firebase getWatch(BuildContext context) {
    //print("watch");
    return context.watch<firebase>();
  }

  static firebase getRead(BuildContext context) {
    //print("read");
    return context.read<firebase>();
  }

  Future<List<product>> getAll() async {
    allProducts.clear();
    print("hh");
    CollectionReference ref = FirebaseFirestore.instance.collection("products");
    QuerySnapshot qssh = await ref.get(); // هان برجع كبشة documents
    List<QueryDocumentSnapshot> listdocs = qssh.docs; // وهان بنحطهم ك list
    listdocs.forEach((element) {
      product toAdd = product(
          name: element["name"],
          id: element["id"],
          type: element["type"],
          times: element["times"],
          cost: element["cost"],
          description: element["description"],
          images: element["images"]);
      allProducts.add(toAdd);
    });
    try {
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return allProducts;
  }

  Future<List<user>> getAllUsers() async {
    allUsers.clear();
    CollectionReference ref = FirebaseFirestore.instance.collection("users");
    QuerySnapshot qssh = await ref.get(); // هان برجع كبشة documents
    List<QueryDocumentSnapshot> listdocs = qssh.docs; // وهان بنحطهم ك list
    listdocs.forEach((element) {
      user toAdd = user(
        name: element["name"],
        id: element["id"],
        password: element["password"],
      );
      allUsers.add(toAdd);
    });
    try {
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return allUsers;
  }

  /*Future<List<product>> getSales(String id) async {
    sales.clear();
    CollectionReference ref = FirebaseFirestore.instance.collection("products");
    CollectionReference ref2 = FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("sales");
    QuerySnapshot qsshid = await ref2
        .orderBy("rank", descending: true)
        .get(); // هان برجع كبشة documents
    List<QueryDocumentSnapshot> listid = qsshid.docs; // وهان بنحطهم ك list
    List<product> ids = [];
    listid.forEach((elementt) {
      String id = elementt["id"];
      String time = elementt["daytime"];
      String date = elementt["daydate"];
      product p = product(id: id, daydate: date, daytime: time);
      ids.add(p);
    });
    ids.forEach((elemente) async {
      QuerySnapshot qsshpro =
          await ref.where("id", isEqualTo: elemente.id).get();
      if (qsshpro.docs.isEmpty) {
      } else {
        final element = qsshpro.docs[0];
        product toAdd = product(
            daydate: elemente.daydate,
            daytime: elemente.daytime,
            name: element["name"],
            id: element["id"],
            type: element["type"],
            times: element["times"],
            cost: element["cost"],
            description: element["description"],
            url: element["url"]);
        sales.add(toAdd);
        try {
          notifyListeners();
        } catch (e) {}
      }
    });
    return sales;
  }
*/
  void refreshSales() {
    sales.clear();
    //  getSales(signInProvider().us!.id!);
  }

  void refreshAll() {
    allProducts.clear();
    getAll();
  }

  void refreshAllUsers() {
    allUsers.clear();
    getAll();
  }
}

/*class firebaseServices {
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
    for (purchase r in pur) {
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
*/