import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:line_icons/line_icons.dart';
import 'package:package_info/package_info.dart';
import 'package:new_travel/models/config.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:easy_localization/easy_localization.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String appVersion = '0.0';
  String packageName = '';

  void initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
      packageName = packageInfo.packageName;
    });
  }

  @override
  void initState() {
    super.initState();
    initPackageInfo();
  }

  void openLincenceDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AboutDialog(
            applicationName: Config().appName,
            applicationIcon: Image(
              image: AssetImage(Config().splashIcon),
              height: 30,
              width: 30,
            ),
            applicationVersion: appVersion,
          );
        });
  }

  void openPrivacyPolicy() async {
    await launch(Config().privacyPolicyUrl);
  }

  void opendeveloperUrl() async {
    await launch(Config().developerUrl);
  }

  void openEmailPopup() async {
    await launch(
        'mailto:${Config().supportEmail}?subject=Apie ${Config().appName} App&body=');
  }

  void openRatingReview() {
    LaunchReview.launch(
        androidAppId: packageName, iOSAppId: Config().appleAppId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings".tr()),
        elevation: 1,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          ListTile(
            leading: Icon(LineIcons.envelope),
            title: Text(
              'Support Email'.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              Config().supportEmail,
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => openEmailPopup(),
          ),
          Divider(
            color: Colors.grey[300],
          ),
          ListTile(
            leading: Icon(
                //LineIcons.star_o
                LineIcons.star),
            title: Text(
              'Rate & Review'.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            onTap: () => openRatingReview(),
          ),
          Divider(
            color: Colors.grey[300],
          ),
          ListTile(
            leading: Icon(LineIcons.lock),
            title: Text(
              'Privacy Policy'.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            onTap: () => openPrivacyPolicy(),
          ),
          Divider(
            color: Colors.grey[300],
          ),
          ListTile(
            leading: Icon(
              //LineIcons.paper_plane
              LineIcons.paperPlane,
            ),
            title: Text(
              'Licence'.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            onTap: () => openLincenceDialog(),
          ),
          Divider(
            color: Colors.grey[300],
          ),
          ListTile(
            leading: Icon(LineIcons.info),
            title: Text(
              'App Version'.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              appVersion,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(
            color: Colors.grey[300],
          ),
          ListTile(
            leading: Icon(LineIcons.code),
            title: Text(
              'Developer'.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            onTap: () => opendeveloperUrl(),
          ),
        ],
      ),
    );
  }
}
