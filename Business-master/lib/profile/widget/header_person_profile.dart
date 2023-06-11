import 'package:business/helper/constanc.dart';
import 'package:business/profile/model/profile_model.dart';
import 'package:business/profile/view/edit_profile_view.dart';
import 'package:business/profile/viewModel/edit_profile_viewmodel.dart';
import 'package:business/profile/viewModel/profile_viewmodel.dart';
import 'package:business/widget/custom_border_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//Mina 10/1/2022 Design Changes
class HeaderPersonProfile extends ConsumerWidget {
  final ProfileModel profileModel;
  final ProfileViewModel viewModel;
  final bool myProfile;

  HeaderPersonProfile({
    required this.profileModel,
    required this.viewModel,
    required this.myProfile,
  });

  @override
  Widget build(BuildContext context, watch) {
    final settingViewModel = watch(editProfileViewModel(profileModel));
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: size.height * .38,
            child: Stack(
              children: <Widget>[
                Container(
                  height: size.height * .3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        profileModel.coverImage ??
                            "https://i.pinimg.com/originals/82/64/7e/82647eca04687361c6d515f335d4c08a.jpg",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  left: size.width * .04,
                  top: size.height * .04,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .044,
                    width: MediaQuery.of(context).size.width * .1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: IconButton(
                      onPressed: () {
                        //   Get.back();
                      },
                      //iconSize: 20.w,
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                myProfile
                    ? Positioned(
                        right: size.width * .03,
                        top: size.height * .03,
                        child: !settingViewModel.isLoadingUploadImage
                            ? InkWell(
                                onTap: () async {
                                  await settingViewModel
                                      .getImageFromGallery("cover");
                                  viewModel.getProfileDetails();
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 8.0,
                                            offset: Offset(0.0, 5.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                      )
                    : SizedBox.shrink(),
                Positioned(
                  right: 0,
                  left: 0,
                  top: size.height * .17,
                  child: Container(
                    width: size.width * .2,
                    height: size.height * .2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(profileModel.personalImage ??
                            "https://i.pinimg.com/originals/82/64/7e/82647eca04687361c6d515f335d4c08a.jpg"),
                      ),
                    ),
                  ),
                ),
                profileModel.myProfile == 1
                    ? Positioned(
                        right: size.width * .03,
                        top: size.height * .3,
                        child: IconButton(
                          onPressed: () async {
                            await Get.to(() => EditProfileView(
                                  profileModel: profileModel,
                                ));
                            viewModel.getProfileDetails();
                          },
                          iconSize: 25.w,
                          icon: Icon(
                            Icons.settings,
                            color: Colors.grey[700],
                          ),
                        ),
                      )
                    : SizedBox(),
                profileModel.myProfile == 0
                    ? Positioned(
                        left: size.width*.04,
                        top: size.height*.38,
                        child: IconButton(
                          onPressed: () =>
                              viewModel.navigationToChatMessageScreen(
                            context: context,
                          ),
                          iconSize: 35.w,
                          icon: Icon(
                            Icons.chat,
                            color: primaryColor,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: profileModel.name,
            alignment: Alignment.center,
            fontSize: 30,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "${profileModel.city} - ${profileModel.country}",
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.location_on_outlined,
                size: 18,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),

          /// todo : in friends page
          profileModel.myProfile == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomBorderButton(
                      onPressed: () {},
                      text: 'الغاء المتابعة',
                    ),
                    CustomBorderButton(
                      onPressed: () {},
                      text: 'الغاء الصداقة',
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
