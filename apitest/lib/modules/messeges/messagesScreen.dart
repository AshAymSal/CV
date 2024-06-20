import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class slMessagesSecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _sfMessagesSecreen();
  }
}

class _sfMessagesSecreen extends StatefulWidget {
  _sfMessagesSecreen({Key? key}) : super(key: key);

  @override
  State createState() => _stateMessagesSecreen();
}

class _stateMessagesSecreen extends State<_sfMessagesSecreen> {
  @override
  Widget build(BuildContext context) {
    var totalheight = MediaQuery.of(context).size.height;
    var totalwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: totalwidth / 15),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          color: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            ClipOval(
              child: Container(height: 20, width: 20, color: Colors.black),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          "anas sosoer",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Spacer(),
                        Text(
                          "4:30pm",
                          style: TextStyle(color: Colors.white70),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "wtf",
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
