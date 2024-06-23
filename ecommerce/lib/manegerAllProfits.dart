import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class slManegerAllProfits extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return sfManegerAllProfits();
  }
}

class sfManegerAllProfits extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return stateManegerAllProfits();
  }
}

class stateManegerAllProfits extends State<sfManegerAllProfits>{
  @override
  Widget build(BuildContext context) {
    final totalHeight=MediaQuery.of(context).size.height;
    final totalWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: totalHeight,width: totalWidth,
        child: Column(
          children: [
            SizedBox(height: totalHeight/10,),
            profits(context),
            SizedBox(height: totalHeight/40,),
            ListTile(title: Text("name"),trailing: Text("times"),),
            //SizedBox(height: totalHeight/40,),
            times(context),
          ],
        ),
      ),
    );
  }

  Widget profits (BuildContext context){
    final totalHeight=MediaQuery.of(context).size.height;
    final totalWidth=MediaQuery.of(context).size.width;
    CollectionReference ref1=FirebaseFirestore.instance.collection("profits");
    return Container(
      width: totalWidth/1.5,height: totalHeight/5,
      color: Colors.blue,
      child: Column(
        children: [
          SizedBox(height: totalHeight/5/4,),
          Text("Total Profits",style: TextStyle(fontSize: 25,color: Colors.white),),
          SizedBox(height: totalHeight/5/8,),
          StreamBuilder<QuerySnapshot>(
            stream: ref1.snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasData) {
                final profit=snapshot.data!.docs[0]["total"];
                return Text(profit,style: TextStyle(fontSize: 20,color: Colors.white),);
              }
              return Container();
            },
          )
        ],
      ),

    );
  }

  Widget times(BuildContext context){
    final totalHeight=MediaQuery.of(context).size.height;
    final totalWidth=MediaQuery.of(context).size.width;
    CollectionReference ref1=FirebaseFirestore.instance.collection("products");
    return Container(
      height: totalHeight/1.65,width: totalWidth,
        child:StreamBuilder<QuerySnapshot>(
          stream: ref1.orderBy("times",descending: true).snapshots(),
          builder: (context,snapshot){
            if(snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final pro = snapshot.data!.docs[index];
                    return ListTile(
                        title: Text(pro["name"]),
                        trailing: Text(pro["times"])
                    );
                  });
            }
            return Container();
          },
        )
    );
  }
}

