import 'package:apitest/constants/Texts.dart';
import 'package:apitest/models/notification.dart';
import 'package:apitest/modules/notifications/notificationsProvider.dart';
import '../../cache/AuthenticationProvider.dart';
import 'package:flutter/material.dart';

class notificationWidget extends StatelessWidget {
  notificationModel notification;
  notificationWidget(this.notification, {Key? key}) : super(key: key);
  late String isSeen;
  @override
  Widget build(BuildContext context) {
    isSeen = notification.seen!;
    var totalheight = MediaQuery.of(context).size.height;
    var totalwidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        if (isSeen == "0") {
          notificationsProvider.getRead(context)
            ..makeNotificationSeen(
                    authProvider.getRead(context).user!.id!, notification.id!)
                .then((value) {
              notificationsProvider
                  .getRead(context)
                  .getAllNotificaions(authProvider.getRead(context).user!.id!);
            });
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 7),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        color: isSeen == "1" ? Color(0xFF4dbeff) : Colors.blue,
        child: Row(children: [
          Container(
            height: 20,
            width: 20,
            child: ClipOval(
              child: Container(
                color: Colors.black,
                height: 20,
                width: 20,
              ),
            ),
          ),
          SizedBox(
            width: totalwidth / 7,
          ),
          Expanded(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${notification.fromWhom}  " +
                      NotificationsStatment().getHashMap()[notification.type],
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(
                  height: totalheight / 80,
                ),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      "4:30pm",
                      style: TextStyle(color: Colors.white70),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
