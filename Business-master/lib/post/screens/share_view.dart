import 'package:business/post/viewmodel/share_post_viewmodel.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupShareView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(getAllSharesPostViewModel);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: customAppBarWithLeading(title: 'الأشخاص الذين شاركوا هذا')
            as PreferredSizeWidget?,
        body: LoadingStack(
          isLoading: viewModel.isLoading,
          child: viewModel.sharePostModel == null
              ? SizedBox()
              : ListView.separated(
                  itemCount: viewModel.sharePostModel!.shares!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      child: Card(
                        elevation: 10,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                              viewModel.shareDataModelList![index].publisherId!
                                  .personalImage!,
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: CustomText(
                                  alignment: Alignment.centerRight,
                                  text: viewModel.shareDataModelList![index]
                                      .publisherId!.name,
                                  fontSize: 14,
                                  color: Colors.black,
                                  height: 1.8,
                                ),
                              ),
                            ],
                          ),
                          // trailing: Container(
                          //     width: 120,
                          //     child: CustomText(
                          //       alignment: Alignment.bottomLeft,
                          //       text: notificationModel[index].time,
                          //       color: Colors.grey,
                          //     )),
                          onTap: () {},
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: 20,
                  ),
                ),
        ),
      ),
    );
  }
}
