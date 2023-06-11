import 'package:business/media/components/music_item_component.dart';
import 'package:business/media/screens/add_music_view.dart';
import 'package:business/media/viewmodel/music_viewmodel.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field_withour_border.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class MusicView extends StatelessWidget {
  const MusicView({
    Key? key,
    required this.myProfile,
  }) : super(key: key);

  final bool myProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWithLeading(title: 'الموسيقي') as PreferredSizeWidget?,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer(
                  builder: (BuildContext context,
                      T Function<T>(ProviderBase<Object?, T>) watch,
                      Widget? child) {
                    final viewModel = watch(musicViewModel);

                    return IconButton(
                      onPressed: () async {
                        var result = await Get.to(() => AddMusicView());
                        print(result);
                        if (result) await viewModel.getAllMusic();
                      },
                      padding: EdgeInsets.only(top: 20),
                      alignment: Alignment.bottomCenter,
                      icon: Icon(
                        Icons.upload_sharp,
                        color: Colors.grey,
                        size: 50,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: CustomTextFormFieldWithoutBorder(
                    hint: 'البحث',
                    onSave: (String? s) {},
                    validator: (String? valid) {},
                    icons: Icons.search,
                  ),
                ),
              ],
            ),
          ),
          Consumer(
            builder: (BuildContext context,
                T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
              final viewModel = watch(musicViewModel);
              return Expanded(
                child: LoadingStack(
                  isLoading: viewModel.isLoading,
                  child: viewModel.musicModel!.length == 0
                      ? Padding(
                          padding: const EdgeInsets.all(100),
                          child: Center(
                            child: CustomText(
                              alignment: Alignment.center,
                              text: "لا يوجود موسيقي",
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: viewModel.musicModel!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return MusicItemComponent(
                              musicModel: viewModel.musicModel![index],
                              onPressDelete: () => viewModel.deleteMusic(
                                viewModel.musicModel![index].id!,
                                index,
                              ),
                            );
                          },
                        ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
