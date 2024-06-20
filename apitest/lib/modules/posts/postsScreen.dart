import 'package:apitest/modules/home/drawer/friends/friendsProvider.dart';
import 'package:apitest/modules/posts/postsProvider.dart';
import 'package:apitest/widgets/postWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class slPostsSecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _sfPostsSecreen();
  }
}

class _sfPostsSecreen extends StatefulWidget {
  _sfPostsSecreen({Key? key}) : super(key: key);
  @override
  State createState() => _statePostsSecreen();
}

class _statePostsSecreen extends State<_sfPostsSecreen> {
  @override
  Widget build(BuildContext context) {
    var totalheight = MediaQuery.of(context).size.height;
    var totalwidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
        create: (BuildContext context) => postsProvider()
          ..getAllPosts(FriendsProvider.getRead(context).friends),
        child: Consumer<postsProvider>(builder: (context, modle, child) {
          var allPosts = modle.allPosts;
          return !modle.isLoaded
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: totalwidth / 20, vertical: 5),
                  color: Color(0xFFccd1ff),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: allPosts.length,
                      itemBuilder: (context, index) {
                        final post = allPosts[index];
                        return postWidget(post);
                      }),
                );
        }));
  }
}
