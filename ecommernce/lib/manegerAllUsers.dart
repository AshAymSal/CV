import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase.dart';
import 'model/user.dart';

class slManegerAllUsers extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return sfManegerAllUsers();
  }
}

class sfManegerAllUsers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return stateManegerAllUsers();
  }
}

class stateManegerAllUsers extends State<sfManegerAllUsers>{
  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<user>>(
        create: (BuildContext context) {
          return context.read<firebase>().getAllUsers();
        },
        initialData: [],
        child: Scaffold(
          body:sfManegerAllUsersProvider(),
        )
    );
  }
}

class sfManegerAllUsersProvider extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return stateManegerAllUsersProvider();
  }

}

class stateManegerAllUsersProvider extends State<sfManegerAllUsersProvider>{
  @override
  Widget build(BuildContext context) {
    var model2 = Provider.of<firebase>(context,listen: true);
    context.read<List<user>>();

    final totalHeight = MediaQuery
        .of(context)
        .size
        .height;
    final totalWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      height: totalHeight, width: totalWidth,
      color: Color(0xffd3faff),
      child: Column(children: [
        SizedBox(height: totalHeight / 20,),
        ListTile(title: Text("id"),leading: Text("name"),trailing: Text("password"),),
        Container(
          height: totalHeight-(totalHeight / 8),
          child: ListView.builder(
              itemCount: model2.allUsers.length,
              itemBuilder: (context, index) {
                if(model2.allUsers.isEmpty){
                  return Container();
                }
                final userr = model2.allUsers[index];
                user us = user(
                  name: userr.name,
                  id: userr.id,
                  password: userr.password
                );
                return ListTile(
                  title: Text(us.id!),
                  leading: Text(us.name!),
                  trailing: Text(us.password!),
                );
              }
          ),
        )
      ],),
    );
  }
}