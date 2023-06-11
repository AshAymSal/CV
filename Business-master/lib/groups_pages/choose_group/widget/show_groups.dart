import 'package:business/groups_pages/choose_group/model/all_group_pages_data_model.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_border_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowGroups extends StatelessWidget {
  const ShowGroups({
    Key? key,
    required this.groupsPagesDataModel,
    required this.onPressedEntered,
    required this.isPage,
    required this.navigateToDetails,
  }) : super(key: key);
  final List<GroupsPagesDataModel>? groupsPagesDataModel;
  final Function(int) onPressedEntered;
  final Function(int) navigateToDetails;
  final bool isPage;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: groupsPagesDataModel!.length,
      padding: EdgeInsets.only(top: 8),
      itemBuilder: (context, index) {
        return Container(
          child: Card(
            elevation: 2,
            child: Consumer(
              builder: (BuildContext context,
                  T Function<T>(ProviderBase<Object, T>) watch, Widget? child) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(groupsPagesDataModel![index]
                            .profileImage ??
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(groupsPagesDataModel![index].name ?? 'name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        groupsPagesDataModel![index].membersCount.toString() +
                            " عضو ",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Icon(
                        groupsPagesDataModel![index].privacy == 1
                            ? Icons.lock
                            : Icons.lock_open,
                        size: 16,
                      ),
                    ],
                  ),
                  trailing: Container(
                    width: 120,
                    child: groupsPagesDataModel![index].entered == 0
                        ? CustomButton(
                            onPressed: () => onPressedEntered(index),
                            color: primaryColor,
                            text: isPage
                                ? getTextButtonPages(
                                    groupsPagesDataModel![index].entered!)
                                : getTextButtonGroup(
                                    groupsPagesDataModel![index].entered!,
                                  ),
                            textColor: Colors.white,
                          )
                        : CustomBorderButton(
                            onPressed: () => onPressedEntered(index),
                            color: Colors.white,
                            text: isPage
                                ? getTextButtonPages(
                                    groupsPagesDataModel![index].entered!)
                                : getTextButtonGroup(
                                    groupsPagesDataModel![index].entered!,
                                  ),
                          ),
                  ),
                  onTap: () => navigateToDetails(index),
                );
              },
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        height: 20,
      ),
    );
  }
}
