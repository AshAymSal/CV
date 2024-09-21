import 'package:flutter/material.dart';
/*
class homeListDrawer extends StatefulWidget {
  bool vis;
  homeListDrawer({super.key, required this.vis});

  @override
  State<homeListDrawer> createState() => _homeListDraerState();
}

class _homeListDraerState extends State<homeListDrawer> {
  @override
  Widget build(BuildContext context) {
   // print("home " + widget.vis.toString());

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ListTile(
          leading: Text("main"),
          trailing: Icon(Icons.exit_to_app),
        ),
        SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.home),
          title: Text(
            'Men',
            style: TextStyle(fontSize: 25),
          ),
          trailing: Icon(Icons.directions_sharp),
          onTap: () {
            setState(() {
              widget.vis = false;
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            'Women',
            style: TextStyle(fontSize: 25),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 400,
        )
      ],
    );
  }
}
*/
