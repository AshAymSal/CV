import 'package:ecommernce/core/widgets/custom_drawer.dart';
import 'package:ecommernce/features/auth/sign_in_page.dart';
import 'package:ecommernce/features/map/location_page.dart';
import 'package:ecommernce/features/products/presentation/pages/favorites_page.dart';
import 'package:ecommernce/features/purchase/presentation/pages/check_out_page.dart';
import 'package:ecommernce/features/purchase/presentation/pages/sales_page.dart';
import 'package:ecommernce/features/auth/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class slSettingsPage extends StatelessWidget {
  CustomDrawerController drawerController;
  slSettingsPage(this.drawerController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sfSettingsPage(drawerController);
  }
}

class sfSettingsPage extends StatefulWidget {
  final CustomDrawerController drawerController;
  const sfSettingsPage(this.drawerController, {Key? key}) : super(key: key);

  @override
  State<sfSettingsPage> createState() => _stateSettingsPage();
}

class _stateSettingsPage extends State<sfSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (widget.drawerController.isOpen) {
            widget.drawerController.toggle;
            print(widget.drawerController.s);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height - 60,
              width: MediaQuery.of(context).size.width,
              color: Color(0xffd3faff),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  FirebaseAuth.instance.currentUser == null
                      ? GestureDetector(
                          child: ListTile(
                            leading: Icon(Icons.login),
                            title: Text("LogIn"),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return signIn();
                            }));
                          },
                        )
                      : Container(
                          child: Text(
                            FirebaseAuth.instance.currentUser!.email!,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                  SizedBox(height: 40),
                  GestureDetector(
                    child: ListTile(
                      leading: Icon(Icons.wallet),
                      title: Text("My Orders"),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CheckOutPage();
                      }));
                    },
                  ),
                  GestureDetector(
                    child: ListTile(
                      leading: Icon(Icons.favorite),
                      title: Text("My Favorites"),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return slFavoritePage();
                      }));
                    },
                  ),
                  GestureDetector(
                    child: ListTile(
                      leading: Icon(Icons.sell),
                      title: Text("My Sales History"),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return slSalePage();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.search),
                    title: Text("My Browser History"),
                  ),
                  GestureDetector(
                    child: ListTile(
                      leading: Icon(Icons.sell),
                      title: Text("Get your shipping location"),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SimpleMap();
                      }));
                    },
                  ),
                  SizedBox(height: 50),
                  FirebaseAuth.instance.currentUser != null
                      ? GestureDetector(
                          child: ListTile(
                            leading: Icon(Icons.logout),
                            title: Text("Log Out"),
                          ),
                          onTap: () {
                            signInProvider.getRead(context).signOut();
                          },
                        )
                      : Container()
                ],
              )),
        ));
  }
}
