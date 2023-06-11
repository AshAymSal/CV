import 'package:ecommernce/modules/detalis/detalisPage.dart';
import 'package:ecommernce/modules/oneProduct/oneProductWidgets.dart';
import 'package:flutter/material.dart';
import 'package:ecommernce/modules/favorites/favoriteProvider.dart';
import 'package:ecommernce/modules/signIn/signInProvider.dart';

Widget favoriteListWidget(BuildContext context) {
  return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: favoriteProvider.getWatch(context).favorites.length,
      itemBuilder: (context, index) {
        final pro = favoriteProvider.getWatch(context).favorites[index];
        return slOneProduct(pro);
      });
}
