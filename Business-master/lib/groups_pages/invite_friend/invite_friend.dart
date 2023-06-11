import 'package:business/model/pages_model.dart';
import 'package:business/profile/view/my_freinds_view.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:flutter/material.dart';

class InviteFriend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBarWithLeading(title: 'دعوة الاصدقاء')
            as PreferredSizeWidget?,
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
                    child: CustomButton(
                      onPressed: () {},
                      text: 'دعوة',
                      textColor: Colors.white,
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
