import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PopularPlacesBloc extends ChangeNotifier {
  List _data = [];
  List get data => _data;
  set data(newData) => _data = newData;

  PopularPlacesBloc() {
    getData();
  }

  Future getData() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('places').get();
    var x = snap.docs;
    _data.clear();
    x.forEach((f) {
      _data.add(f);
    });
    _data.sort((a, b) => b['loves'].compareTo(a['loves']));
    notifyListeners();
  }
}
