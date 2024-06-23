import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/model/product.dart';
import 'package:flutter/material.dart';


class slManegerProductDetalis extends StatelessWidget{
  int wh;
  product? pro;
  slManegerProductDetalis(this.wh,this.pro, {Key? key}):super (key: key);
  @override
  Widget build(BuildContext context) {
    return sfManegerProductDetalis(wh,pro);
  }
}

class sfManegerProductDetalis extends StatefulWidget{
  int wh;
  product? pro;
  sfManegerProductDetalis(this.wh,this.pro, {Key? key}):super (key: key);
  @override
  State<StatefulWidget> createState() {
    return stateManegerProductDetalis(wh,pro);
  }
}

class stateManegerProductDetalis extends State<sfManegerProductDetalis>{
  int wh;
  product? pro;
  stateManegerProductDetalis(this.wh,this.pro);

  final list=["jacket","boots","jeans","tshirt"];
  String? val;

  @override
  void initState() {
    super.initState();
    val=list[0];
    if(wh==1){
      name.text=pro!.name!;
      cost.text=pro!.cost!;
      val=pro!.type!;
      discription.text=pro!.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight=MediaQuery.of(context).size.height;
    final totalWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: totalHeight,width: totalWidth,
          color: Color(0xffd3faff),
          child: Column(children: [
            SizedBox(height: totalHeight/8,),
            wh==1?toEdit(context):toAdd(context),
          ],),
        ),
      )
    );
  }
  TextEditingController name= TextEditingController();
  TextEditingController discription= TextEditingController();
  TextEditingController cost= TextEditingController();

  Widget toAdd(BuildContext context){
    final totalHeight=MediaQuery.of(context).size.height;
    final totalWidth=MediaQuery.of(context).size.width;
    return Container(
      child: Column(children: [
        Container(
          color: Colors.red,
          height: totalHeight/5,width: totalWidth/2,
        ),
        SizedBox(height: totalHeight/15,),
        Container(child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Type : "),
            Container(
                width: totalWidth/1.5,color:Colors.white,padding: EdgeInsets.symmetric(horizontal: totalWidth/30),
                child: DropdownButtonHideUnderline(
                  child:  DropdownButton(
                    isExpanded: true,
                    value: val,
                    items: list.map(buildmenu).toList(),
                    onChanged: (value){setState(() {
                      val = value as String?;
                    });},
                  ),
                )
            )],)),
        SizedBox(height: totalHeight/40,),
        Container(child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Text("Name : "),Container(width: totalWidth/1.5,color:Colors.white,padding: EdgeInsets.symmetric(horizontal: totalWidth/30),child: TextField(controller: name,decoration: InputDecoration(border: InputBorder.none)))],)),
        SizedBox(height: totalHeight/40,),
        Container(child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Text("Cost : "),Container(width: totalWidth/1.5,color:Colors.white,padding: EdgeInsets.symmetric(horizontal: totalWidth/30),child: TextField(controller: cost,decoration: InputDecoration(border: InputBorder.none)))],)),
        SizedBox(height: totalHeight/40,),
        Container(child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Container(child: Text("Discription : ")),Container(height: totalHeight/4,width: totalWidth/1.7,color:Colors.white,padding: EdgeInsets.symmetric(horizontal: totalWidth/30),child: TextField(textInputAction: TextInputAction.newline,maxLines: 7,controller: discription,decoration: InputDecoration(border: InputBorder.none)))],)),
        SizedBox(height: totalHeight/40,),
        ElevatedButton(onPressed: () async{
          CollectionReference ref=FirebaseFirestore.instance.collection("products");
          ref.add({
            "name":name.text,
            "cost":cost.text,
            "description":discription.text,
            "type":val,
            "times":"0",
          });
          final refId= await FirebaseFirestore.instance.collection("products").where("name",isEqualTo: name.text).get();
          final doc=refId.docs[0].id;
          ref.doc(doc).set({
            "name":name.text,
            "cost":cost.text,
            "description":discription.text,
            "type":val,
            "times":"0",
            "id":doc
          }).then((value) {
            Navigator.of(context).pop();
          });
        }, child: Text("Add")),
      ],
      ),
    );
  }

  Widget toEdit(BuildContext context){
    final totalHeight=MediaQuery.of(context).size.height;
    final totalWidth=MediaQuery.of(context).size.width;
    return Container(
      child: Column(children: [
        Container(
          color: Colors.red,
          height: totalHeight/5,width: totalWidth/2,
        ),
        SizedBox(height: totalHeight/15,),
        Container(child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Type : "),
            Container(
                width: totalWidth/1.5,color:Colors.white,padding: EdgeInsets.symmetric(horizontal: totalWidth/30),
                child: DropdownButtonHideUnderline(
                  child:  DropdownButton(
                    isExpanded: true,
                    value: val,
                    items: list.map(buildmenu).toList(),
                    onChanged: (value){setState(() {
                      val = value as String?;
                    });},
                  ),
                )
            )],)),
        SizedBox(height: totalHeight/40,),
        Container(child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Text("Name : "),Container(width: totalWidth/1.5,color:Colors.white,padding: EdgeInsets.symmetric(horizontal: totalWidth/30),child: TextField(controller: name,decoration: InputDecoration(border: InputBorder.none)))],)),
        SizedBox(height: totalHeight/40,),
        Container(child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Text("Cost : "),Container(width: totalWidth/1.5,color:Colors.white,padding: EdgeInsets.symmetric(horizontal: totalWidth/30),child: TextField(controller: cost,decoration: InputDecoration(border: InputBorder.none)))],)),
        SizedBox(height: totalHeight/40,),
        Container(child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Container(child: Text("Discription : ")),Container(height: totalHeight/4,width: totalWidth/1.7,color:Colors.white,padding: EdgeInsets.symmetric(horizontal: totalWidth/30),child: TextField(controller: discription,decoration: InputDecoration(border: InputBorder.none)))],)),
        SizedBox(height: totalHeight/40,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              CollectionReference ref=FirebaseFirestore.instance.collection("products");
              ref.doc(pro!.id!).update({
                "name":name.text,
                "cost":cost.text,
                "description":discription.text,
                "type":val,
              }).then((_) {
               // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Edit Done")));
              });
              Navigator.of(context).pop();
            }, child: Text("Edit")),
            SizedBox(width: totalWidth/5),
            ElevatedButton(onPressed: (){
              CollectionReference ref=FirebaseFirestore.instance.collection("products");
              ref.doc(pro!.id!).delete().then((_) {
               // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Delete Done")));
              });
              Navigator.of(context).pop();
            }, child: Text("Delete")),
          ],
        ),
      ],
      ),
    );
  }

  DropdownMenuItem<String> buildmenu (String a){
    return DropdownMenuItem(value:a,child: Text(a));
  }
}