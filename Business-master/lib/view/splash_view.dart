import 'package:business/authintication/login/login_view.dart';
import 'package:business/chatting/repos/chatting_details_repo.dart';
import 'package:business/chatting/repos/recent_chat_repo.dart';
import 'package:business/core/network/local/shared_preferences_service.dart';
import 'package:business/core/services/firebase_messaging_service.dart';
import 'package:business/profile/model/profile_model.dart';
import 'package:business/view/control_view/control_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    clientModel = context.read(sharedPreferencesServiceProvider).getUserData();
    super.initState();
  }

  late ProfileModel? clientModel;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    /// Online
    if (state == AppLifecycleState.resumed) {
      if (clientModel != null) {
        RecentChatRepo.instance
            .makeUserOnlineOffline(status: true, clientId: clientModel!.id!);
        RecentChatRepo.instance.saveCurrentUserToken(
          clientId: clientModel!.id!,
          userToken: FirebaseNotifications.instance.userToken!,
        );
      }
    } else {
      /// Offline
      if (clientModel != null) {
        RecentChatRepo.instance.makeUserOnlineOffline(
          status: false,
          clientId: clientModel!.id!,
        );
        ChattingDetailsRepo.instance.setClientWriteNow(
          writeNow: false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context,
          T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
        final viewModel = watch(sharedPreferencesServiceProvider);
        return Scaffold(
          body: SplashScreenView(
            navigateRoute: viewModel.getUserData() == null
                ? LoginView()
                : viewModel.getUserData()!.id != null
                    ? ControlView()
                    // ? ControlViewTest()
                    : LoginView(),
            duration: 5000,
            imageSize: 400,
            imageSrc: "assets/images/logo.png",
            backgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}
