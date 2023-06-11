// import 'dart:io';
//
// import 'package:business/groups_pages/group_details/viewmodel/add_post_to_group_viewmodel.dart';
// import 'package:business/widget/button/custom_button.dart';
// import 'package:business/widget/custom_text.dart';
// import 'package:business/widget/custom_text_form_field_without_icon.dart';
// import 'package:business/widget/loading_stack.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
//
// class AddPostToGroupView extends ConsumerWidget {
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context, watch) {
//     final viewModel = watch(addPostToGroupViewModel);
//     return Scaffold(
//       appBar: AppBar(
//         brightness: Brightness.light,
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         leading: IconButton(
//           color: Colors.black,
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//           ),
//         ),
//         title: CustomText(
//           alignment: Alignment.center,
//           text: 'اضافة منشور',
//           color: Colors.black,
//           fontSize: 24,
//         ),
//       ),
//       body: SafeArea(
//         child: LoadingStack(
//           isLoading: viewModel.isLoading,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20.0, right: 20),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 20,
//                         ),
//                         CustomTextFormFieldWithoutIcon(
//                           hint: 'شرح الموضوع',
//                           validator: (String? value) {
//                             if (value!.length == 0) {
//                               return 'يجب اضافة شرح للموضوع';
//                             }
//                           },
//                           controller: viewModel.postDescriptionController,
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GetImageWidget(),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 CustomButton(
//                   width: Get.width - 40,
//                   onPressed: () async {
//                     formKey.currentState!.save();
//                     if (formKey.currentState!.validate()) {
//                       await viewModel.addPostToGroup();
//                     }
//                   },
//                   text: 'نشر',
//                   color: Colors.grey.shade200,
//                   height: 50,
//                   textColor: Colors.black,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class GetImageWidget extends ConsumerWidget {
//   const GetImageWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, watch) {
//     final viewModel = watch(addPostToGroupViewModel);
//     return viewModel.imageFiles.length > 0
//         ? Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 alignment: WrapAlignment.spaceEvenly,
//                 children: viewModel.imageFiles
//                     .map(
//                       (item) => Stack(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(20),
//                             width: Get.width / 2,
//                             height: Get.height / 3,
//                             child: Image.file(
//                               File(item.path),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           Positioned(
//                             top: 10,
//                             left: 5,
//                             child: GestureDetector(
//                               onTap: () {
//                                 viewModel.deleteSelectedImage(item);
//                               },
//                               child: Container(
//                                 height: 30,
//                                 width: 30,
//                                 decoration: BoxDecoration(
//                                   color: Colors.red,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Icon(
//                                   Icons.clear,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                     .toList()
//                     .cast<Widget>(),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               GestureDetector(
//                 onTap: () async {
//                   await viewModel.pickedFilesImages();
//                 },
//                 child: Container(
//                   width: Get.width - 40,
//                   child: Image.asset(
//                     'assets/images/add_image.png',
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//             ],
//           )
//         : GestureDetector(
//             onTap: () async {
//               await viewModel.pickedFilesImages();
//             },
//             child: Container(
//               width: Get.width,
//               child: Image.asset(
//                 'assets/images/add_image.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           );
//   }
// }
