import 'dart:convert';

import 'package:http/http.dart' as http;

class Post {
  String? date;
  String? id;
  String? text;
  String? fromWhom;
  String? urlImage;
  List? likes;
  List? comments;
  List? shares;

  Post(
      {this.id,
      this.date,
      this.text,
      this.fromWhom,
      this.likes,
      this.comments,
      this.shares,
      this.urlImage});

  /*factory post.withJson(Map<String, dynamic> a) {
    post re = post(fromWhom: a["fromWhom"], id: a["id"], text: a["text"],date: a["date"],urlImage: a["urlImage"],likes: a["likes"],comments: ["comments"],shares: ["shares"]);
    return re;
  }*/
  factory Post.withJson(Map<String, dynamic> a) {
    List likess = [];
    List commentss = [];

    for (var like in a["Likes"]) {
      likess.add(Like.withJson(like));
    }
    for (var comment in a["Comments"]) {
      commentss.add(Comment.withJson(comment));
    }

    Post re = Post(
        fromWhom: a["fromWhom"],
        id: a["id"],
        text: a["text"],
        date: a["date"],
        likes: likess,
        comments: commentss);

    return re;
  }
}

class Like {
  String? fromWhom;

  Like({this.fromWhom});

  factory Like.withJson(Map<String, dynamic> a) {
    Like re = Like(
      fromWhom: a["fromWhom"],
    );
    return re;
  }
}

class Comment {
  String? id;
  String? fromWhom;
  String? text;
  bool? isDeletable;

  Comment({this.fromWhom, this.id, this.text, this.isDeletable});

  factory Comment.withJson(Map<String, dynamic> a) {
    Comment re = Comment(
        fromWhom: a["fromWhom"],
        id: a["id"],
        text: a["text"],
        isDeletable: a["isDeletable"]);
    return re;
  }
}
