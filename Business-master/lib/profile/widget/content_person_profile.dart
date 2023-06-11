import 'package:business/profile/model/profile_model.dart';
import 'package:business/profile/view/choose_follows_view.dart';
import 'package:business/profile/view/my_freinds_view.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//Mina 10/1/2022 Design Changes

class ContentPersonProfile extends StatelessWidget {
  final ProfileModel profileModel;

  ContentPersonProfile({required this.profileModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 20),
      child: Container(
        child: Column(
          children: [
            contentInfo(
              info: profileModel.jobTitle ?? '',
              color: Color.fromRGBO(249, 165, 7, 1),
              imagePath: 'assets/images/settings.png',
              topLeft: 5,
              onPress: () {},
              topRight: 5,
            ),
            contentInfo(
              info: profileModel.businessType ?? 'اسم الشركة',
              color: Color.fromRGBO(255, 191, 0, 1),
              imagePath: 'assets/images/type.png',
              onPress: () {},
            ),
            contentInfo(
              info: profileModel.specialty ?? 'المؤهل العلمي',
              color: Color.fromRGBO(242, 174, 47, 1),
              imagePath: 'assets/images/field.png',
              onPress: () {},
            ),
            contentInfo(
              info: 'الاصدقاء',
              color: Color.fromRGBO(255, 183, 48, 1),
              imagePath: 'assets/images/friends.png',
              onPress: () {
                Get.to(() => MyFriendsView());
              },
            ),
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomButton(
                      textColor: Colors.black,
                      onPressed: () {
                        Get.to(() => ChooseFollowsView());
                      },
                      text: '${profileModel.followingsNum}    اتابع',
                      color: Color.fromRGBO(249, 218, 35, 1),
                      borderRadiusGeometry: BorderRadius.circular(3),
                    ),
                  ),
                  SizedBox(
                    width: 2.h,
                  ),
                  Expanded(
                    child: CustomButton(
                      textColor: Colors.black,
                      onPressed: () {
                        Get.to(() => ChooseFollowsView());
                      },
                      borderRadiusGeometry: BorderRadius.circular(3),
                      text: '${profileModel.followersNum}    المتابعين',
                      color: Color.fromRGBO(249, 218, 35, 1),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget contentInfo({
    required String info,
    required Color color,
    required Function onPress,
    required imagePath,
    double topLeft = 0,
    double topRight = 0,
  }) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: onPress as void Function()?,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft),
              topRight: Radius.circular(topRight),
            ),
            color: color,
          ),
          padding: EdgeInsets.only(right: 10),
          height:40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
              ),
              SizedBox(
                width: 20,
              ),
              CustomText(
                alignment: Alignment.centerRight,
                text: info,
                fontSize: 20,
                maxLine: 1,
                fontWeight: FontWeight.w100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
