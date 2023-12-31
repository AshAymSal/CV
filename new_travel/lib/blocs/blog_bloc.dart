import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_travel/models/icon_data.dart';
import 'package:new_travel/utils/toast.dart';

import 'package:easy_localization/easy_localization.dart';

class BlogBloc extends ChangeNotifier {
  List _data = [];

  String _popSelection = 'popular';
  bool _hasData = false;
  int _loves = 0;
  Icon _loveIcon = LoveIcon().normal;
  Icon _bookmarIcon = BookmarkIcon().normal;
  List _lovedBlogs = [];
  List _bookmarkedBlogs = [];

  BlogBloc() {
    getData();
  }

  set data(newValue) {
    _data = newValue;
  }

  set popSelection(newValue) {
    _popSelection = newValue;
  }

  set hasData(data) {
    _hasData = data;
  }

  set loves(newLoves) {
    _loves = newLoves;
  }

  set loveIcon(newLoveIcon) {
    _loveIcon = newLoveIcon;
  }

  set bookmarkIcon(newBookmarkIcon) {
    _bookmarIcon = newBookmarkIcon;
  }

  set lovedBlogs(newItem) => _lovedBlogs = newItem;
  set bookmarkedBlogs(newItem1) => _bookmarkedBlogs = newItem1;

  List get data => _data;

  String get popSelection => _popSelection;
  bool get hasData => _hasData;
  int get loves => _loves;
  Icon get loveIcon => _loveIcon;
  Icon get bookmarkIcon => _bookmarIcon;
  List get lovedBlogs => _lovedBlogs;
  List get bookamrkedBlogs => _bookmarkedBlogs;

  Future getData() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('blogs').get();
    var x = snap.docs;
    _data.clear();
    x.forEach((f) => _data.add(f));
    afterPopSelection(_popSelection);
  }

  afterPopSelection(value) {
    _popSelection = value;
    _popSelection == 'popular'
        ? _data.sort((a, b) => b['loves'].compareTo(a['loves']))
        : _data.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
    notifyListeners();
  }

  Future getLovesAmount(timestamp) async {
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('blogs').doc(timestamp);
    DocumentSnapshot snap = await ref.get();
    int loves = snap['loves'];
    _loves = loves;

    notifyListeners();
  }

  Future getLovedList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    if (_uid == null) return;
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    DocumentSnapshot snap = await ref.get();
    // List d = snap.data['loved blogs'];  // لسا بدنا
    List? d = snap['loved blogs'];
    _lovedBlogs = d!;

    notifyListeners();
  }

  Future getBookmarkedList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    if (_uid == null) return;
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    DocumentSnapshot snap = await ref.get();
    //List d = snap.data['bookmarked blogs']; // لسا بدنا
    List? d = snap['bookmarked blogs'];
    _bookmarkedBlogs = d!;

    notifyListeners();
  }

  void loveIconCheck(timestamp) async {
    if (_lovedBlogs.contains(timestamp)) {
      _loveIcon = LoveIcon().bold;
    } else {
      _loveIcon = LoveIcon().normal;
    }
    notifyListeners();
  }

  Future bookmarkIconCheck(timestamp) async {
    if (_bookmarkedBlogs.contains(timestamp)) {
      _bookmarIcon = BookmarkIcon().bold;
    } else {
      _bookmarIcon = BookmarkIcon().normal;
    }
    notifyListeners();
  }

  loveIconClicked(timestamp) async {
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('blogs').doc(timestamp);

    if (_lovedBlogs.contains(timestamp)) {
      _removeFromLove(timestamp);
      await getLovedList();
      loveIconCheck(timestamp);
      ref.update({'loves': _loves - 1});
      getLovesAmount(timestamp);
    } else {
      _addtoLove(timestamp);

      await getLovedList();
      loveIconCheck(timestamp);
      ref.update({'loves': _loves + 1});
      getLovesAmount(timestamp);
    }

    notifyListeners();
  }

  void _addtoLove(timestamp) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);

    List firstItem = [timestamp];

    if (_lovedBlogs == null) {
      ref.update({'loved blogs': FieldValue.arrayUnion(firstItem)});
    } else {
      _lovedBlogs.add(timestamp);
      ref.update({'loved blogs': FieldValue.arrayUnion(_lovedBlogs)});
    }

    notifyListeners();
  }

  void _removeFromLove(timestamp) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    List d = [timestamp];
    ref.update({'loved blogs': FieldValue.arrayRemove(d)});
  }

  void _addtoBookmark(timestamp, context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);

    List firstItem = [timestamp];

    if (_bookmarkedBlogs == null) {
      ref.update({'bookmarked blogs': FieldValue.arrayUnion(firstItem)});
    } else {
      _bookmarkedBlogs.add(timestamp);
      ref.update({'bookmarked blogs': FieldValue.arrayUnion(_bookmarkedBlogs)});
    }
    notifyListeners();
    openToast(context, 'Added to your bookmark'.tr());
  }

  void _removeFromBookmark(timestamp, context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    List d = [timestamp];
    ref.update({'bookmarked blogs': FieldValue.arrayRemove(d)});
    openToast(context, 'Removed from your bookmark'.tr());
  }

  Future bookmarkIconClicked(timestamp, context) async {
    if (_bookmarkedBlogs.contains(timestamp)) {
      _removeFromBookmark(timestamp, context);
      await getBookmarkedList();
      bookmarkIconCheck(timestamp);
    } else {
      _addtoBookmark(timestamp, context);
      await getBookmarkedList();
      bookmarkIconCheck(timestamp);
    }

    notifyListeners();
  }
}
