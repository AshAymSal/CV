import 'package:apitest/models/post.dart';
import 'package:apitest/modules/posts/postsProvider.dart';
import 'package:apitest/cache/AuthenticationProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class postWidget extends StatefulWidget {
  Post post;
  postWidget(this.post, {Key? key}) : super(key: key);

  @override
  State<postWidget> createState() => _postWidgetState(post);
}

class _postWidgetState extends State<postWidget> {
  _postWidgetState(this.post);
  Post post;
  @override
  Widget build(BuildContext context) {
    TextEditingController text = TextEditingController();
    var totalheight = MediaQuery.of(context).size.height;
    var totalwidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
        create: (context) => onePostProvider(post)
          ..isPostLiked(context)
          ..initialLikes()
          ..initialComments(),
        child: Consumer<onePostProvider>(builder: (context, modle, child) {
          return Container(
              color: Colors.white,
              padding: EdgeInsets.all(totalwidth / 30),
              margin: EdgeInsets.only(top: totalheight / 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: totalwidth / 30,
                      ),
                      Text(post.fromWhom!),
                      Spacer(),
                      Text(post.date!),
                    ],
                  ),
                  SizedBox(
                    height: totalheight / 50,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 60,
                      ),
                      Text(post.text!),
                    ],
                  ),
                  SizedBox(
                    height: totalheight / 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white70),
                          ),
                          onPressed: () {
                            modle.likeReaction(
                                authProvider.getRead(context).user!.id!);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              modle.isLiked
                                  ? Icon(
                                      Icons.favorite,
                                      size: 18,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_border_outlined,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                              Text(
                                "  (${modle.likes!.length})",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white70),
                          ),
                          onPressed: () {
                            var modlee = onePostProvider.getRead(context);
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                //isDismissible: false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                context: context,
                                builder: (context) {
                                  return Provider.value(
                                    value: modlee,
                                    child: DraggableScrollableSheet(
                                        initialChildSize: .9,
                                        //maxChildSize: 1,
                                        builder: (context, __) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: totalwidth / 20,
                                                vertical: 5),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                  child: ListView.builder(
                                                      itemCount: modlee
                                                          .comments!.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return commentWidget(
                                                            modlee.comments![
                                                                index]);
                                                      }),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .blue),
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          // color: Colors.white,
                                                          child: TextField(
                                                            controller: text,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          )),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        //  print(text.text);
                                                        modle
                                                            .addComment(
                                                                authProvider
                                                                    .getRead(
                                                                        context)
                                                                    .user!
                                                                    .id!,
                                                                modle.post.id!,
                                                                text.text)
                                                            .then((value) {
                                                          setState(() {
                                                            text.text = "";
                                                          });
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.send,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom,
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                  );
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.comment,
                                size: 18,
                                color: Colors.black,
                              ),
                              Text(
                                "  (${modle.comments!.length})",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white70),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.share,
                                size: 18,
                                color: Colors.black,
                              ),
                              Text(
                                "  (${post.id})",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
        }));
  }

  Widget commentWidget(Comment comment) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            color: Colors.red,
          ),
          SizedBox(
            width: 40,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${comment.fromWhom}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "${comment.text}",
                style: TextStyle(fontSize: 17),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
