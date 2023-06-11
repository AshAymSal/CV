import 'package:business/profile/model/activiry_profile_model.dart';
import 'package:business/widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonActivityListView extends StatelessWidget {
  final bool myProfile;

  PersonActivityListView({required this.myProfile});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height*.12,
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: activityListView.length,
        itemBuilder: (context, int index) {
          return InkWell(
            onTap: () => activityListView[index].onPressed(myProfile),
            child: Column(
              children: [
                Image.asset(
                  activityListView[index].image!,
                ),
                SizedBox(
                  height: size.height*.02,
                ),
                CustomText(
                  text: activityListView[index].title,
                  color: Colors.black,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: size.width*.04,
          );
        },
      ),
    );
  }
}
