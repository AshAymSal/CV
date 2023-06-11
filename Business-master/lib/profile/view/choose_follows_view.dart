import 'package:business/helper/constanc.dart';
import 'package:business/profile/view/my_freinds_view.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_border_button.dart';
import 'package:flutter/material.dart';

class ChooseFollowsView extends StatefulWidget {
  @override
  _ChooseFollowsViewState createState() => _ChooseFollowsViewState();
}

class _ChooseFollowsViewState extends State<ChooseFollowsView> {
  int buttonSelected = 0;

  @override
  Widget build(BuildContext context) {
    print(buttonSelected);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBarWithLeading(title: 'حسابى') as PreferredSizeWidget?,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 60,
                      onPressed: () {
                        setState(() {
                          buttonSelected = 1;
                        });
                      },
                      text: 'المتابعين  (3)',
                      color: buttonSelected == 1 ? primaryColor : Colors.white,
                      textColor:
                          buttonSelected == 1 ? Colors.white : primaryColor,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      height: 60,
                      onPressed: () {
                        setState(() {
                          buttonSelected = 0;
                        });
                      },
                      text: 'اتابع  (10)',
                      color: buttonSelected == 1 ? Colors.white : primaryColor,
                      textColor:
                          buttonSelected == 1 ? primaryColor : Colors.white,
                    ),
                  ),
                ],
              ),
              buttonSelected == 0
                  ? Expanded(child: allPages())
                  : Expanded(child: myPages()),
            ],
          ),
        ),
      ),
    );
  }

  Widget allPages() {
    return ListView.separated(
      itemCount: friendData.length,
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
                child: friendData[index].isFriend
                    ? CustomBorderButton(
                        onPressed: () {
                          setState(() {
                            friendData[index].isFriend = false;
                          });
                        },
                        color: Colors.white,
                        text: 'الغاء المتابعة',
                      )
                    : CustomButton(
                        onPressed: () {
                          setState(() {
                            print(friendData[index].isFriend);
                            friendData[index].isFriend = true;
                          });
                        },
                        text: ' متابعة',
                        textColor: Colors.white,
                      ),
              ),
              onTap: () {
                // Get.to(() => PageDetailsView());
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

  Widget myPages() {
    return ListView.separated(
      itemCount: friendData.length,
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
                  text: 'الغاء المتابعة',
                ),
              ),
              onTap: () {
                // Get.to(() => PageDetailsView());
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
