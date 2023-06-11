import 'package:business/helper/constanc.dart';
import 'package:business/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:  AppBar(
          elevation: 0.0,
          titleSpacing: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: CustomText(
              text: 'الاشعارات',
              alignment: Alignment.center,
              fontSize: 24,
              color: primaryColor,
            ),
          ),
          actions: [IconButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_forward_ios_sharp),
          )],
        ),
        body: ListView.separated(
          itemCount: notificationModel.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              child: Card(
                elevation: 18,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(notificationModel[index].image),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CustomText(
                          alignment: Alignment.centerRight,
                          text: notificationModel[index].name +
                              '  ' +
                              notificationModel[index].content,
                          fontSize: 14,
                          color: Colors.black,
                          height: 1.8,
                        ),
                      ),
                    ],
                  ),
                  trailing: Container(
                      width: 120,
                      child: CustomText(
                        alignment: Alignment.bottomLeft,
                        text: notificationModel[index].time,
                        color: Colors.grey,
                      )),
                  onTap: () {},
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 20,
          ),
        ),
      ),
    );
  }
}

class NotificationModel {
  String name, content, image, time;

  NotificationModel({
    required this.name,
    required this.content,
    required this.image,
    required this.time,
  });
}

final List<NotificationModel> notificationModel = [
  NotificationModel(
    name: 'محمد ناجي',
    content: 'اعجب بمنشورك',
    image: 'assets/images/person.png',
    time: '2:15',
  ),
  NotificationModel(
    name: 'يسرا',
    content: 'اعجبت بمنشورك',
    image: 'assets/images/person.png',
    time: '2:15',
  ),
  NotificationModel(
    name: 'علق ابراهيم محمد ',
    content: 'علي منشورك',
    image: 'assets/images/person.png',
    time: '2:15',
  ),
];
