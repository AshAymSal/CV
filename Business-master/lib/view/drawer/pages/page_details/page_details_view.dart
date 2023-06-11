// import 'package:business/helper/constanc.dart';
// import 'package:business/view/drawer/pages/page_details/widget/page_details_about_page.dart';
// import 'package:business/view/drawer/pages/page_details/widget/page_details_images.dart';
// import 'package:business/view/drawer/pages/page_details/widget/page_details_my_ads.dart';
// import 'package:business/view/drawer/pages/page_details/widget/page_details_video.dart';
// import 'package:business/widget/button/custom_button.dart';
// import 'package:business/widget/custom_border_button.dart';
// import 'package:business/widget/custom_text.dart';
// import 'package:flutter/material.dart';
//
// class PageDetailsView extends StatefulWidget {
//   @override
//   _PageDetailsViewState createState() => _PageDetailsViewState();
// }
//
// class _PageDetailsViewState extends State<PageDetailsView> {
//   int lastSelected = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final double circleRadius = 150.0;
//
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: CustomScrollView(
//           slivers: [
//             SliverPadding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
//               sliver: SliverToBoxAdapter(
//                 child: Container(
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 400,
//                         width: double.infinity,
//                         child: Stack(children: <Widget>[
//                           Container(
//                             height: 300,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage(
//                                     'assets/images/shop_profile.png'),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             right: 10,
//                             top: 230,
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: circleRadius,
//                                   height: circleRadius,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.white,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black26,
//                                         blurRadius: 8.0,
//                                         offset: Offset(0.0, 5.0),
//                                       ),
//                                     ],
//                                   ),
//                                   child: CircleAvatar(
//                                     radius: 30.0,
//                                     backgroundImage: AssetImage(
//                                         'assets/images/shop_profile.png'),
//                                     backgroundColor: Colors.transparent,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.only(top: 70, right: 20),
//                                   child: Column(
//                                     children: [
//                                       // todo : make it responsive with media query
//                                       CustomText(
//                                         fontSize: 24,
//                                         text: 'بيع وشراء',
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       CustomText(
//                                         fontSize: 16,
//                                         color: Colors.grey,
//                                         text: '3 الاف اعجاب',
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             left: 5,
//                             top: 300,
//                             child: CustomBorderButton(
//                               onPressed: () {},
//                               text: 'الغاء الاعجاب',
//                             ),
//                           ),
//                         ]),
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(top: 30),
//                         height: 80,
//                         child: ListView.separated(
//                           itemCount: option.length,
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               width: 150,
//                               child: CustomButton(
//                                 onPressed: () => _selectedButton(index),
//                                 text: option[index].name,
//                                 color: option[index].isSelected
//                                     ? primaryColor
//                                     : Colors.grey[200],
//                                 textColor: option[index].isSelected
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                             );
//                           },
//                           separatorBuilder: (BuildContext context, int index) =>
//                               SizedBox(
//                             width: 5,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             lastSelected == 0
//                 ? PagesDetailsMyAds()
//                 : lastSelected == 1
//                     ? PagesDetailsImages()
//                     : lastSelected == 2
//                         ? PagesDetailsVideo()
//                         : lastSelected == 3
//                             ? PagesDetailsAboutPage()
//                             : PagesDetailsMyAds(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _selectedButton(int index) {
//     print(index);
//     setState(() {
//       option[lastSelected].isSelected = false;
//       option[index].isSelected = true;
//     });
//     lastSelected = index;
//   }
// }
//
// class ListOfOptions {
//   String name;
//   bool isSelected;
//
//   ListOfOptions({
//     required this.name,
//     required this.isSelected,
//   });
// }
//
// final List<ListOfOptions> option = [
//   ListOfOptions(name: 'الرئيسية', isSelected: true),
//   ListOfOptions(name: 'الصور', isSelected: false),
//   ListOfOptions(name: 'الفيديو', isSelected: false),
//   ListOfOptions(name: 'عن الصفحة', isSelected: false),
//   ListOfOptions(name: 'اعلاناتى', isSelected: false),
// ];
