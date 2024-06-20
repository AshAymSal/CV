import 'package:apitest/modules/notifications/notificationsProvider.dart';
import 'package:apitest/widgets/notificationWidget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../cache/AuthenticationProvider.dart';

class slNotificationsSecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* notificationsProvider
        .getRead(context)
        .getAllNotificaions(authProvider.getRead(context).user!.id!);*/
    return _sfNotificationsSecreen();
  }
}

class _sfNotificationsSecreen extends StatefulWidget {
  _sfNotificationsSecreen({Key? key}) : super(key: key);
  @override
  State createState() => _stateNotificationsSecreen();
}

class _stateNotificationsSecreen extends State<_sfNotificationsSecreen> {
  late notificationsProvider prov;
  late authProvider auth;

  @override
  void dispose() {
    // TODO: implement dispose
    //prov.clearList();
    //prov.dispose();
    /*Future.delayed(
        Duration.zero, () => prov.makeAllNotificationsSeen(auth.user!.id!));*/
    print("dipose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // prov = notificationsProvider.getWatch(context);
    auth = authProvider.getRead(context);

    var totalheight = MediaQuery.of(context).size.height;
    var totalwidth = MediaQuery.of(context).size.width;
    return Consumer<notificationsProvider>(builder: (context, modle, child) {
      return Scaffold(
          body: !modle.isLoaded
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return notificationWidget(modle.allNotifications[index]);
                    },
                    itemCount: modle.allNotifications.length,
                  ),
                ));
    });
  }
}
