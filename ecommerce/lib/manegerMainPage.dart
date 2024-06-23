

import 'package:ecommernce/manegerAllUsers.dart';
import 'package:flutter/material.dart';

import 'manegerAllProducts.dart';
import 'manegerAllProfits.dart';

class slManegerHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final totalHeight=MediaQuery.of(context).size.height;
    final totalWidth=MediaQuery.of(context).size.width;
    return Container(
      height: totalHeight,width: totalWidth,
      color: Color(0xffd3faff),
      child: Column(children: [
        SizedBox(height: totalHeight/4,),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return slManegerAllProducts();
          }));
        }, child: Text("All Products")),
        SizedBox(height: totalHeight/8,),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return slManegerAllUsers();
          }));
        }, child: Text("All Users")),
        SizedBox(height: totalHeight/8,),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return slManegerAllProfits();
          }));
        }, child: Text("All Profits")),

      ],),
    );
  }
}