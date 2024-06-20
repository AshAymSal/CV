import 'dart:convert';
import 'package:apitest/cache/AuthenticationProvider.dart';
import 'package:apitest/Opirations.dart';
import 'package:apitest/constants/Texts.dart';
import 'package:apitest/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../cache/AuthenticationRepo.dart';

class postsProvider extends ChangeNotifier {
  static postsProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<postsProvider>();
  }

  static postsProvider getRead(BuildContext context) {
    //print("read");
    return context.read<postsProvider>();
  }

  List allPosts = [];
  bool isLoaded = false;

  Future<List<dynamic>> getAllPosts(List friends) async {
    postsRepo().getAllPosts(friends).then((value) {
      allPosts = Opirations().sortPosts(value);
      isLoaded = true;
      notifyListeners();
    });

    return allPosts;
  }
}

class onePostProvider extends ChangeNotifier {
  bool isLiked = false;
  Post post;
  List? comments;
  List? likes;
  onePostProvider(this.post);

  static onePostProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<onePostProvider>();
  }

  static onePostProvider getRead(BuildContext context) {
    //print("read");
    return context.read<onePostProvider>();
  }

  void initialLikes() {
    likes = post.likes;
  }

  void initialComments() {
    comments = post.comments;
  }

  void isPostLiked(BuildContext context) {
    for (var like in post.likes!) {
      if (like.fromWhom == authProvider.getRead(context).user!.id!.toString()) {
        isLiked = true;
        notifyListeners();
        break;
      }
    }
  }

  Future likeReaction(String idU) async {
    postsRepo().likeReaction(idU, post.id!).then((value) {
      postsRepo().getLikes(idU, post.id!).then((value) {
        likes = value;
        isLiked = !isLiked;
        notifyListeners();
      });
    });
  }

  Future addComment(String idU, String idP, String text) async {
    postsRepo().addComment(idU, idP, text).then((value) {
      postsRepo().getComments(idU, post.id!).then((value) {
        //comments!.clear();
        comments = value;
        notifyListeners();
      });
    });
  }
}

class postsRepo {
  Future<List<dynamic>> getAllPosts(List friends) async {
    var map = new Map<String, dynamic>();
    map["action"] = "GET_POSTS";
    var allPosts = [];
    for (int i = 0; i < friends.length; i++) {
      map["USER_ID"] = friends[i].id.toString();
      var res = await http.post(Uri.parse(baseUrl), body: map);
      var postsByWhom = [];
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (data["status"]) {
          for (var s in data["data"]) {
            postsByWhom.add(Post.withJson(s));
          }
          allPosts.addAll(postsByWhom);
          print("Get All Posts : DONE");
        }
      }
    }
    return allPosts;
  }

  Future likeReaction(String idU, String idP) async {
    var map = new Map<String, dynamic>();
    map["action"] = "LIKE_REACTION";
    map["USER_ID"] = idU;
    map["POST_ID"] = idP;
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print("Like Reaction : DONE");
      } else {
        print("Like Reaction : FAILED");
      }
    }
  }

  Future addComment(String idU, String idP, String text) async {
    var map = new Map<String, dynamic>();
    map["action"] = "ADD_COMMENT";
    map["USER_ID"] = idU;
    map["POST_ID"] = idP;
    map["COMMENT_TEXT"] = text;
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print("Add Comment : DONE");
      } else {
        print("Add Comment : FAILED");
      }
    }
  }

  Future<List> getLikes(String idU, String idP) async {
    var map = new Map<String, dynamic>();
    map["action"] = "GET_LIKES";
    map["USER_ID"] = idU;
    map["POST_ID"] = idP;
    List likes = [];
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print("GET LIKES : DONE");
        for (var s in data["data"]) {
          likes.add(Like.withJson(s));
        }
      } else {
        print("GET LIKES: FAILED");
      }
    }
    return likes;
  }

  Future<List> getComments(String idU, String idP) async {
    var map = new Map<String, dynamic>();
    map["action"] = "GET_COMMENTS";
    map["USER_ID"] = idU;
    map["POST_ID"] = idP;
    List comments = [];
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print("GET COMMENTS : DONE");
        for (var s in data["data"]) {
          print(s);
          comments.add(Comment.withJson(s));
        }
      } else {
        print("GET COMMENTS: FAILED");
      }
    }
    return comments;
  }
}
