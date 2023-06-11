import 'package:business/authintication/login/login_view.dart';
import 'package:business/chatting/screen/recent_chat/resent_chat_screen.dart';
import 'package:business/company_delivery/company_view.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/home/screens/home_screen.dart';
import 'package:business/home/screens/search_view.dart';
import 'package:business/profile/view/profile_view.dart';
import 'package:business/services/view/all_category_screen.dart';
import 'package:business/view/add_post/view/add_post_view.dart';
import 'package:business/view/control_view/viewmodel/control_view_model.dart';
import 'package:business/view/drawer/saved_view/saved_view.dart';
import 'package:business/view/notification/notification_view.dart';
import 'package:business/widget/custom_text.dart';
import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:drawerbehavior/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ControlView extends ConsumerWidget {
  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AddPostView(),
    AllCategoryScreen(),
    ResentChatScreen(),
    ProfileScreen(),
    CompanyView(),
  ];

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(controlViewModel);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: viewModel.selectIndex == 0
            ? DrawerScaffold(
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  title: CustomText(
                    alignment: Alignment.center,
                    text: 'الرئيسية',
                    color: primaryColor,
                    fontSize: 24,
                  ),
                  iconTheme: IconThemeData(color: Colors.black),
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Get.to(() => NotificationView());
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.search,
                        color: Colors.black,
                        size: 18,
                      ),
                      onPressed: () {
                        Get.to(() => SearchView());
                      },
                    ),
                  ],
                ),
                builder: (context, id) {
                  return Center(
                    child: _widgetOptions.elementAt(viewModel.selectIndex),
                  );
                },
                drawers: [
                  SideDrawer(
                   alignment: Alignment(0.7, -0.7),
                    slide: true,
                    percentage: 0.9,
                    menu: menuWithIcon,
                    selectorColor: primaryColor,
                    direction: Direction.right,
                    color: Colors.white,
                    selectedItemId: viewModel.selectedMenuItemId,
                    onMenuItemSelected: (index) =>
                        changeDrawer(index, viewModel),
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                bottomNavigationBar: _bottomNavBar(),
              )
            : Scaffold(
                body: _widgetOptions.elementAt(viewModel.selectIndex),
                bottomNavigationBar: _bottomNavBar(),
              ));
  }

  changeDrawer(var index, ControlViewModel viewModel) {
    print(index);
    switch (index) {
      // case 0:
      //   Get.to(() => ChoosePagesView());
      //   break;
      // case 1:
      //   Get.to(() => ChooseGroupsView());
      //   break;
      case 2:
        Get.to(() => SavedView());
        break;
      case 3:
        break;
      case 4:
        viewModel.logout();
        Get.offAll(() => LoginView());
        break;
    }
  }

  _bottomNavBar() {
    return Consumer(
      builder: (BuildContext context,
          T Function<T>(ProviderBase<Object, T>) watch, Widget? child) {
        final viewModel = watch(controlViewModel);
        return Theme(
          data: Get.theme.copyWith(
            canvasColor: primaryColor,
            textTheme: Get.theme.textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow)),
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/bottomnav/home.png"),
                  size: 16,
                ),
                label: 'الرئيسية ',
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/bottomnav/add.png"),
                    size: 16,
                  ),
                  label: 'اضافة'),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/bottomnav/services.png"),
                    size: 16,
                  ),
                  label: 'الخدمات'),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/bottomnav/chat.png"),
                    size: 16,
                  ),
                  label: 'الرسائل'),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/bottomnav/profile1.jpg"),
                    size: 16,
                  ),
                  label: 'حسابى'),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/bottomnav/Shipping.png"),
                    size: 16,
                  ),
                  label: 'الشحن'),
            ],
            backgroundColor: primaryColor,
            unselectedItemColor: darkColor,
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: viewModel.changedItem,
            currentIndex: viewModel.selectIndex,
          ),
        );
      },
    );
  }
}

final menuWithIcon = Menu(
  items: [
 /*   MenuItem<int>(
      id: 0,
      title: '     الصفحات',
      prefix: ImageIcon(
        AssetImage("assets/images/drawer/paper.png"),
      ),
    ),
    MenuItem<int>(
      id: 1,
      title: '     المجموعات',
      prefix: ImageIcon(
        AssetImage("assets/images/drawer/group.png"),
      ),
    ),*/
    MenuItem<int>(
      id: 2,
      title: '     العناصر المحفوظة',
      prefix: ImageIcon(
        AssetImage("assets/images/drawer/saved.png"),
      ),
    ),
     MenuItem<int>(
       id: 3,
       title: '     اللغة',
       prefix: ImageIcon(
         AssetImage("assets/images/drawer/language.png"),
       ),
     ),
    MenuItem<int>(
      id: 3,
      title: '     تواصل معنا',
      prefix: ImageIcon(
        AssetImage("assets/images/drawer/contact_us.png"),
      ),
    ),
    MenuItem<int>(
      id: 4,
      title: '     تسجيل خروج',
      prefix: ImageIcon(
        AssetImage("assets/images/drawer/logout.png"),
        color: Colors.red,
      ),
    ),
  ],
);
