import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_travel/models/icon_data.dart';
import 'package:new_travel/utils/toast.dart';
//import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';

class PlaceBloc extends ChangeNotifier {
  List _data = [];

  bool _hasData = false;
  bool _isAudioPlay = true;
  int _loves = 0;
  int _commentCount = 0;
  Icon _loveIcon = LoveIcon().normal;
  Icon _bookmarIcon = BookmarkIcon().normal;
  Icon _audioIcon = AudioIcon().play;
  List _filteredData = [];
  List _lovedPlaces = [];
  List _bookmarkedPlaces = [];
  bool _isExistingAuido = true;

  AudioPlayer _advencedPlayer = AudioPlayer();
  //AudioCache _audioCache;

  PlaceBloc() {
    getData();
  }

  set data(newValue) {
    _data = newValue;
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

  set filteredData(newData) {
    _filteredData = newData;
  }

  set commentsCount(newComment) {
    _commentCount = newComment;
  }

  set lovedPlaces(newItem) => _lovedPlaces = newItem;
  set bookmarkedPlaces(newValue) => _bookmarkedPlaces = newValue;
  //set audioCache(newValue) => _audioCache = newValue;

  List get data => _data;
  bool get hasData => _hasData;
  int get loves => _loves;
  Icon get loveIcon => _loveIcon;
  Icon get audioIcon => _audioIcon;
  Icon get bookmarkIcon => _bookmarIcon;
  List get filteredData => _filteredData;
  int get commentsCount => _commentCount;
  List get lovedPlaces => _lovedPlaces;
  List get bookmarkedPlaces => _bookmarkedPlaces;
  //AudioCache get audioCache => _audioCache;
  AudioPlayer get advencedPlayer => _advencedPlayer;

  Future getData() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('places').get();
    var x = snap.docs;
    _data.clear();

    x.forEach((f) {
      _data.add(f);
    });
    data.shuffle();
  }

  Future getLovedList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    if (_uid == null) return;
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    DocumentSnapshot snap = await ref.get();
    //List d = snap.data['loved places'];
    List d = snap['loved places'];
    _lovedPlaces = d;

    notifyListeners();
  }

  Future getBookmarkedList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    if (_uid == null) return;
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    DocumentSnapshot snap = await ref.get();
    //List d = snap.data['bookmarked places'];
    List d = snap['bookmarked places'];
    _bookmarkedPlaces = d;

    notifyListeners();
  }

  Future getLovesAmount(timestamp) async {
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('places').doc(timestamp);
    DocumentSnapshot snap = await ref.get();
    int loves = snap['loves'];
    _loves = loves;
    notifyListeners();
  }

  Future getCommentsAmount(timestamp) async {
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('places').doc(timestamp);
    DocumentSnapshot snap = await ref.get();
    int comments = snap['comments count'];
    _commentCount = comments;
    notifyListeners();
  }

  Future commentsIncrement(timestamp) async {
    // FirebaseFirestore.instance.collection('places').doc(timestamp).updateData({'comments count': _commentCount + 1});
    FirebaseFirestore.instance
        .collection('places')
        .doc(timestamp)
        .set({'comments count': _commentCount + 1});
  }

  Future commentsDecrement(timestamp) async {
    //  FirebaseFirestore.instance.collection('places').doc(timestamp).updateData({'comments count': _commentCount - 1});
    FirebaseFirestore.instance
        .collection('places')
        .doc(timestamp)
        .set({'comments count': _commentCount - 1});
  }

  void loveIconCheck(timestamp) async {
    if (_lovedPlaces.contains(timestamp)) {
      _loveIcon = LoveIcon().bold;
    } else {
      _loveIcon = LoveIcon().normal;
    }

    notifyListeners();
  }

  Future bookmarkIconCheck(timestamp) async {
    if (_bookmarkedPlaces.contains(timestamp)) {
      _bookmarIcon = BookmarkIcon().bold;
    } else {
      _bookmarIcon = BookmarkIcon().normal;
    }
    notifyListeners();
  }

  loveIconClicked(timestamp) async {
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('places').doc(timestamp);

    if (_lovedPlaces.contains(timestamp)) {
      _removeFromLove(timestamp);

      await getLovedList();
      loveIconCheck(timestamp);
      //ref.updateData({'loves': _loves - 1});
      ref.set({'loves': _loves - 1});
      getLovesAmount(timestamp);
    } else {
      _addtoLove(timestamp);

      await getLovedList();
      loveIconCheck(timestamp);
      //ref.updateData({'loves': _loves + 1});
      ref.set({'loves': _loves + 1});
      getLovesAmount(timestamp);
    }

    notifyListeners();
  }

  audioInit(String assetsPath) async {
    _isAudioPlay = true;
    _audioIcon = AudioIcon().play;
    // _audioCache = new AudioCache(fixedPlayer: _advencedPlayer);

    try {
      _advencedPlayer.setUrl("url");
      //await _audioCache.loop(assetsPath);
      _advencedPlayer.setVolume(5);
      _isExistingAuido = true;
      notifyListeners();
    } catch (e) {
      _isExistingAuido = false;
    }
  }

  Future audioClear() async {
    if (!_isExistingAuido) return;
    await _advencedPlayer.stop();
  }

  audioIconClicked() async {
    if (!_isExistingAuido) return;
    if (_isAudioPlay) {
      _audioIcon = AudioIcon().stop;
      _advencedPlayer.pause();
    } else {
      _audioIcon = AudioIcon().play;
      try {
        _advencedPlayer.resume();
      } catch (e) {}
    }
    _isAudioPlay = !_isAudioPlay;
    notifyListeners();
  }

  void _addtoLove(timestamp) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);

    List firstItem = [timestamp];

    if (_lovedPlaces == null) {
      // ref.updateData({'loved places': FieldValue.arrayUnion(firstItem)});
      ref.set({'loved places': FieldValue.arrayUnion(firstItem)});
    } else {
      _lovedPlaces.add(timestamp);
      //ref.updateData({'loved places': FieldValue.arrayUnion(_lovedPlaces)});
      ref.set({'loved places': FieldValue.arrayUnion(_lovedPlaces)});
    }

    notifyListeners();
  }

  void _removeFromLove(timestamp) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    List d = [timestamp];
    //ref.updateData({'loved places': FieldValue.arrayRemove(d)});
    ref.set({'loved places': FieldValue.arrayRemove(d)});
  }

  void _addtoBookmark(timestamp, context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);

    List firstItem = [timestamp];

    if (_bookmarkedPlaces == null) {
      //ref.updateData({'bookmarked places': FieldValue.arrayUnion(firstItem)});
      ref.set({'bookmarked places': FieldValue.arrayUnion(firstItem)});
    } else {
      _bookmarkedPlaces.add(timestamp);
      // ref.updateData({'bookmarked places': FieldValue.arrayUnion(_bookmarkedPlaces)});
      ref.set({'bookmarked places': FieldValue.arrayUnion(_bookmarkedPlaces)});
    }
    openToast(context, 'Added to your bookmark'.tr());

    notifyListeners();
  }

  void _removeFromBookmark(timestamp, context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    List d = [timestamp];
    //ref.updateData({'bookmarked places': FieldValue.arrayRemove(d)});
    ref.set({'bookmarked places': FieldValue.arrayRemove(d)});
    openToast(context, 'Removed from your bookmark'.tr());
  }

  Future bookmarkIconClicked(timestamp, context) async {
    if (_bookmarkedPlaces.contains(timestamp)) {
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

  afterSearch(value) {
    _filteredData = _data
        .where((u) =>
            (u['place name'].toLowerCase().contains(value.toLowerCase()) ||
                u['location'].toLowerCase().contains(value.toLowerCase()) ||
                u['description'].toLowerCase().contains(value.toLowerCase())))
        .toList();

    notifyListeners();
  }
}
