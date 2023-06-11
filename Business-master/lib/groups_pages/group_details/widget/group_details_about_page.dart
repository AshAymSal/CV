import 'package:business/groups_pages/group_details/model/group_details_data_model.dart';
import 'package:business/widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupsDetailsAboutPage extends StatelessWidget {
  final PageOrGroupDetails? pageOrGroupDetails;

  GroupsDetailsAboutPage({this.pageOrGroupDetails});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(20),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                CustomText(
                  alignment: Alignment.topRight,
                  fontSize: 24,
                  text: 'وصف المجموعة',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  alignment: Alignment.topRight,
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.grey,
                  text: pageOrGroupDetails!.description.toString(),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  alignment: Alignment.topRight,
                  fontSize: 24,
                  text: 'قوانين المجموعة',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  alignment: Alignment.topRight,
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.grey,
                  text: pageOrGroupDetails!.rules.toString(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
