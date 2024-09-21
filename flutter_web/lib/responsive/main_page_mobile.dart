import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/features/auth/presentation/bloc/product/auth_bloc.dart';
import 'package:flutter_web/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter_web/features/products/presentation/widgets/ShopByCategory.dart';
import 'package:flutter_web/features/products/presentation/widgets/ShowAllProducts.dart';
import 'package:flutter_web/features/language/languege_widget.dart';
import 'package:flutter_web/mainPageWidget/trailing_widget.dart';
import 'package:flutter_web/responsive/drawer.dart';

class MainPageMobile extends StatefulWidget {
  // user u;
  const MainPageMobile({super.key});

  @override
  State<MainPageMobile> createState() => _MainPageState();
}

class _MainPageState extends State<MainPageMobile> {
  late ScrollController _scrollController;
  double pos = 90;
  double temp = 0;
  bool vis = true;
  bool vis2 = false;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (n) {
          // print("lestin");
          if (_scrollController.position.userScrollDirection ==
                  ScrollDirection.reverse ||
              _scrollController.position.pixels < 30) {
            if (vis2 != false) {
              // print("false");
              setState(() {
                vis2 = false;
              });
            }
          } else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
            if (vis2 != true) {
              // print("true");

              setState(() {
                vis2 = true;
              });
            }
          }

          if (_scrollController.position.pixels > 30) {
            setState(() {
              vis = false;
            });
          } else {
            setState(() {
              temp = _scrollController.position.pixels;
              vis = true;
            });
          }
          return false;
        },
        child: Scaffold(
            //  appBar: AppBar(),
            key: globalKey,
            endDrawer: const Drawer(
                width: 290,
                shape: RoundedRectangleBorder(),
                backgroundColor: Colors.red,
                child: NestedDrawer()),
            body: Stack(children: [
              CustomScrollView(controller: _scrollController, slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      vis
                          ? Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              color: Colors.white,
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child:
                                        Image.asset('assets/images/nike.png'),
                                  ),
                                  const Spacer(),
                                  context.watch<AuthBloc>().u == null
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/login');
                                          },
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          ))
                                      : GestureDetector(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.green,
                                          ),
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: Row(
                                      children: [
                                        const Icon(Icons
                                            .shopping_cart_checkout_outlined),
                                        context.watch<AuthBloc>().u == null
                                            ? Container()
                                            : Text(context
                                                .watch<CartBloc>()
                                                .cartItems
                                                .length
                                                .toString()),
                                      ],
                                    ),
                                    onTap: () {
                                      if (context.read<AuthBloc>().u == null) {
                                        Navigator.pushNamed(context, '/login');
                                      } else {
                                        Navigator.pushNamed(
                                            context, '/checkoutPage',
                                            arguments: context
                                                .read<CartBloc>()
                                                .cartItems);
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: const SizedBox(
                                      height: 40,
                                      width: 40,
                                      //color: Colors.blue,
                                      child: Icon(
                                        Icons.list,
                                        size: 35,
                                      ),
                                    ),
                                    onTap: () {
                                      // print("opeeen");
                                      globalKey.currentState?.openEndDrawer();
                                    },
                                  ),
                                ],
                              ))
                          : SizedBox(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                            ),

                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          color: Colors.black,
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                              fit: BoxFit.fill,
                              'https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExYng2Z2t0ZGRhcXdzdnMxZXl3bjJra3hsY3k1dHBieGd2amRmcHEwayZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Dwz4Bc2lj5yyPNvSV9/giphy.webp')),

                      // SL(),
                      const SizedBox(
                        height: 80,
                      ),
                      const ShopByCategory(),

                      const SizedBox(
                        height: 80,
                      ),
                      const ShowAllProducts(),

                      const SizedBox(
                        height: 80,
                      ),
                      const TrailingWidget(),
                      const SizedBox(
                        height: 30,
                      ),
                      LanguageWidget(),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                )
              ]),
              AnimatedPositioned(
                  top: vis2 ? 0 : -70,
                  duration: const Duration(milliseconds: 200),
                  child: Visibility(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          color: Colors.white,
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset('assets/images/nike.png'),
                              ),
                              const Spacer(),
                              context.watch<AuthBloc>().u == null
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ))
                                  : GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.green,
                                      ),
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                child: Row(
                                  children: [
                                    const Icon(
                                        Icons.shopping_cart_checkout_outlined),
                                    context.watch<AuthBloc>().u == null
                                        ? Container()
                                        : Text(context
                                            .watch<CartBloc>()
                                            .cartItems
                                            .length
                                            .toString()),
                                  ],
                                ),
                                onTap: () {
                                  if (context.read<AuthBloc>().u == null) {
                                    Navigator.pushNamed(context, '/login');
                                  } else {
                                    Navigator.pushNamed(
                                        context, '/checkoutPage',
                                        arguments:
                                            context.read<CartBloc>().cartItems);
                                  }
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                child: const SizedBox(
                                  height: 40,
                                  width: 40,
                                  //color: Colors.blue,
                                  child: Icon(
                                    Icons.list,
                                    size: 35,
                                  ),
                                ),
                                onTap: () {
                                  //   print("opeeen");
                                  globalKey.currentState?.openEndDrawer();

                                  //  Scaffold.of(context).openDrawer();
                                },
                              ),
                            ],
                          ))
                      // visible: vis2,
                      )),
            ])));
  }
}
