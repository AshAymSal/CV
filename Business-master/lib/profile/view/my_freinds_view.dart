import 'package:business/model/pages_model.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_border_button.dart';
import 'package:flutter/material.dart';

class MyFriendsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:
            customAppBarWithLeading(title: 'الاصدقاء') as PreferredSizeWidget?,
        body: ListView.separated(
          itemCount: pagesModels.length,
          itemBuilder: (context, index) {
            return Container(
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(friendData[index].image),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(friendData[index].name),
                  subtitle: Text(friendData[index].follows),
                  trailing: Container(
                    width: 120,
                    child: CustomBorderButton(
                      onPressed: () {},
                      text: 'الغاء الصداقة',
                    ),
                  ),
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

class FriendsModel {
  String name, image, follows;
  bool isFriend;

  FriendsModel({
    required this.name,
    required this.image,
    required this.follows,
    required this.isFriend,
  });
}

final List<FriendsModel> friendData = [
  FriendsModel(
      name: 'عربى السيد',
      image: 'assets/images/person.png',
      follows: '3الاف متابع',
      isFriend: true),
  FriendsModel(
      name: 'عربى السيد',
      image: 'assets/images/person.png',
      follows: '3الاف متابع',
      isFriend: true),
  FriendsModel(
      name: 'عربى السيد',
      image: 'assets/images/person.png',
      follows: '3الاف متابع',
      isFriend: true),
  FriendsModel(
      name: 'عربى السيد',
      image: 'assets/images/person.png',
      follows: '3الاف متابع',
      isFriend: true),
];
final List<FriendsModel> groupManager = [
  FriendsModel(
      name: 'عربى السيد',
      image: 'assets/images/person.png',
      follows: '3الاف متابع',
      isFriend: false),
];
