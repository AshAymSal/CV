import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkBloc extends ChangeNotifier {
  List _blogData = [];
  List get blogData => _blogData;
  set blogData(newData) => _blogData = newData;

  List _placeData = [];
  List get placeData => _placeData;
  set placeData(newData1) => _placeData = newData1;

  Future getBlogData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    if (_uid == null) return;
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    DocumentSnapshot snap = await ref.get();
    List? d = snap['bookmarked blogs'];
    // List d = snap.data['bookmarked blogs'];

    _blogData.clear();

    FirebaseFirestore.instance
        .collection('blogs')
        .get()
        .then((QuerySnapshot snap) {
      var x = snap.docs;
      for (var item in x) {
        if (d!.contains(item['timestamp'])) {
          _blogData.add(item);
        }
      }
      notifyListeners();
    });
  }

  Future getPlaceData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    if (_uid == null) return;

    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    DocumentSnapshot snap = await ref.get();
    List? d = snap['bookmarked places'];
    //List d = snap.data['bookmarked places'];
    if (_uid == null) return;
    _placeData.clear();

    FirebaseFirestore.instance
        .collection('places')
        .get()
        .then((QuerySnapshot snap) {
      var x = snap.docs;
      for (var item in x) {
        if (d!.contains(item['timestamp'])) {
          _placeData.add(item);
        }
      }
      notifyListeners();
    });
  }
}
