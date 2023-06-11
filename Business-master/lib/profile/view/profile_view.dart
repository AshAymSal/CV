import 'package:business/helper/constanc.dart';
import 'package:business/post/components/post_components.dart';
import 'package:business/profile/viewModel/profile_viewmodel.dart';
import 'package:business/profile/widget/person_activity_listview.dart';
import 'package:business/services/view/services_view.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../widget/content_person_profile.dart';
import '../widget/header_person_profile.dart';

class ProfileScreen extends ConsumerWidget {
  final int? userId;

  ProfileScreen({this.userId});

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(profileViewModel(userId ?? -1));
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoadingStack(
        isLoading: viewModel.isLoading,
        child: viewModel.isLoading
            ? SizedBox()
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: HeaderPersonProfile(
                      profileModel: viewModel.profileModel,
                      viewModel: viewModel,
                      myProfile:
                          viewModel.profileModel.myProfile == 0 ? false : true,
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: ContentPersonProfile(
                    profileModel: viewModel.profileModel,
                  )),
                  SliverToBoxAdapter(
                      child: PersonActivityListView(
                    myProfile:
                        viewModel.profileModel.myProfile == 0 ? false : true,
                  )),
                  SliverToBoxAdapter(// Mina 10/1/2022
                     child:Column(
                       children:[ Container(
                         height: 1,
                         width: MediaQuery.of(context).size.width,
                         color: Colors.grey,
                       ),
                         SizedBox(
                           height: 8,
                         ),
                       ]
                     )
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              borderRadiusGeometry: BorderRadius.circular(8.0),
                              height: 55,
                              onPressed: () {
                                viewModel.chooseButton(1);
                              },
                              text: 'المنشورات',
                              color: viewModel.buttonSelected == 1
                                  ? primaryColor
                                  : Colors.white,
                              textColor: viewModel.buttonSelected == 1
                                  ? Colors.white
                                  : Colors.black,
                              borderSide:viewModel.buttonSelected == 1
                                  ?BorderSide(color: Colors.white, width: 1)
                                  :BorderSide(color: Colors.black, width: 1)
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomButton(
                              borderRadiusGeometry: BorderRadius.circular(8.0),
                              height: 55,
                              onPressed: () {
                                viewModel.chooseButton(0);
                              },
                              text: 'الخدمات',
                              color: viewModel.buttonSelected == 1
                                  ? Colors.white
                                  : primaryColor,
                              textColor: viewModel.buttonSelected == 1
                                  ? Colors.black
                                  : Colors.white,
                                borderSide:viewModel.buttonSelected == 0
                                    ?BorderSide(color: Colors.white, width: 1)
                                    :BorderSide(color: Colors.black, width: 1)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  viewModel.buttonSelected == 1
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Column(
                                children: [
                                  PostComponent(
                                    post: viewModel.postsModelList[index],
                                    postIndex: index,
                                    id: userId,
                                  ),
                                  Container(
                                    color: Colors.grey[200],
                                    height: 35,
                                  )
                                ],
                              );
                            },
                            childCount: viewModel.postsModelList.length,
                          ),
                        )
                      : SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200.0,
                            mainAxisSpacing: 5.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: .950,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    () => ServicesView(
                                      viewModel.servicesList[index],
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: size.height*.13,
                                        child: FadeInImage.assetNetwork(
                                          fadeInDuration: Duration(seconds: 1),
                                          fit: BoxFit.cover,
                                          placeholder:
                                              "assets/images/waiting.png",
                                          image: viewModel.servicesList[index]
                                                      .media!.length >
                                                  0
                                              ? viewModel
                                                  .servicesList[index].media![0]
                                              : "https://th.bing.com/th/id/OIP.hTQHlnEVJc6lMKqO49vcfAAAAA?pid=ImgDet&rs=1",
                                        ),
                                      ),
                                      Text(
                                        viewModel.servicesList[index].title ??
                                            '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            viewModel.servicesList[index]
                                                    .price ??
                                                0.0.toString(),
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        alignment: Alignment.bottomRight,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount: viewModel.servicesList.length,
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
