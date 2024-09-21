import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/features/language/lang.dart';
import 'package:flutter_web/features/auth/presentation/bloc/product/auth_bloc.dart';
import 'package:flutter_web/features/auth/presentation/bloc/product/auth_event.dart';
import 'package:flutter_web/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter_web/features/products/presentation/widgets/ShopByCategory.dart';
import 'package:flutter_web/features/products/presentation/widgets/ShowAllProducts.dart';
import 'package:flutter_web/mainPageWidget/ListMen.dart';
import 'package:flutter_web/mainPageWidget/ListWomen.dart';
import 'package:flutter_web/features/language/languege_widget.dart';
import 'package:flutter_web/mainPageWidget/listKids.dart';
import 'package:flutter_web/mainPageWidget/trailing_widget.dart';

class MainPageWeb extends StatefulWidget {
  // user u;
  const MainPageWeb({super.key});

  @override
  State<MainPageWeb> createState() => _MainPageState();
}

class _MainPageState extends State<MainPageWeb> {
  bool _isHoveredMen = false;
  bool _isHoveredWomen = false;
  bool _isHoveredKids = false;

  void _onHoverMen(bool hovering) {
    setState(() {
      _isHoveredMen = hovering;
    });
  }

  void _onHoverWomen(bool hovering) {
    setState(() {
      _isHoveredWomen = hovering;
    });
  }

  void _onHoverKids(bool hovering) {
    setState(() {
      _isHoveredKids = hovering;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (n) {
          // print("lestin");
          if (_scrollController.position.userScrollDirection ==
                  ScrollDirection.reverse ||
              _scrollController.position.pixels < 30) {
            if (vis2 != false) {
              //print("false");
              setState(() {
                vis2 = false;
              });
            }
          } else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
            if (vis2 != true) {
              //     print("true");

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
            body: Stack(children: [
          CustomScrollView(controller: _scrollController, slivers: <Widget>[
            SliverAppBar(
                // collapsedHeight: 40,
                toolbarHeight: 30,
                backgroundColor: const Color.fromARGB(31, 192, 192, 192),
                primary: true,
                pinned: false,
                title: Row(
                  children: [
                    GestureDetector(
                      child: SizedBox(
                        //padding: const EdgeInsets.symmetric(horizontal: 50),
                        //  color: Colors.black,
                        height: 80,
                        width: 80,
                        child: Image.asset('assets/images/nike.png'),
                      ),
                      onTap: () {
                        //  print("whhhy");
                      },
                    ),
                    const Spacer(),
                    context.watch<AuthBloc>().u == null
                        ? Container()
                        : Text(
                            '${AppLocalizations.of(context).translate('welcome')} ${context.read<AuthBloc>().u!.username}'),
                    const Spacer(),
                    context.watch<AuthBloc>().u == null
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              AppLocalizations.of(context).translate('sign_in'),
                              style: const TextStyle(fontSize: 14),
                            ),
                          )
                        : Row(
                            children: [
                              //   Text('Welcome  ${context.read<AuthBloc>().u!.username}'),
                              const SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(const LogoutEvent());
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('sign_out'),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/userCartsList',
                                    arguments: context.read<AuthBloc>().u!.id,
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('my_carts'),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(
                      width: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppLocalizations.of(context).translate('help'),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                )),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  vis
                      ? Container(
                          color: Colors.white,
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              SizedBox(
                                child: MouseRegion(
                                    onEnter: (_) => _onHoverMen(true),
                                    onExit: (_) => _onHoverMen(false),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('men'),
                                      style: const TextStyle(fontSize: 18),
                                    )),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                child: MouseRegion(
                                    onEnter: (_) => _onHoverWomen(true),
                                    onExit: (_) => _onHoverWomen(false),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('women'),
                                      style: const TextStyle(fontSize: 18),
                                    )),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                child: MouseRegion(
                                    onEnter: (_) => _onHoverKids(true),
                                    onExit: (_) => _onHoverKids(false),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('kids'),
                                      style: const TextStyle(fontSize: 18),
                                    )),
                              ),
                              const Spacer(),
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
                                width: 40,
                              )
                            ],
                          ))
                      : SizedBox(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                        ),

                  GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        color: Colors.black,
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                            fit: BoxFit.fill,
                            'https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExYng2Z2t0ZGRhcXdzdnMxZXl3bjJra3hsY3k1dHBieGd2amRmcHEwayZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Dwz4Bc2lj5yyPNvSV9/giphy.webp')),
                    onTap: () {},
                  ),

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
                  const LanguageWidget(),
                  const SizedBox(
                    height: 30,
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
                      color: Colors.white,
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          SizedBox(
                            child: MouseRegion(
                                onEnter: (_) => _onHoverMen(true),
                                onExit: (_) => _onHoverMen(false),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('mens'),
                                  style: const TextStyle(fontSize: 18),
                                )),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            child: MouseRegion(
                                onEnter: (_) => _onHoverWomen(true),
                                onExit: (_) => _onHoverWomen(false),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('womens'),
                                  style: const TextStyle(fontSize: 18),
                                )),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            child: MouseRegion(
                                onEnter: (_) => _onHoverKids(true),
                                onExit: (_) => _onHoverKids(false),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('kids'),
                                  style: const TextStyle(fontSize: 18),
                                )),
                          ),
                          const Spacer(),
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
                              if (context.watch<AuthBloc>().u == null) {
                                Navigator.pushNamed(context, '/login');
                              } else {
                                Navigator.pushNamed(context, '/checkoutPage',
                                    arguments:
                                        context.read<CartBloc>().cartItems);
                              }
                            },
                          ),
                          const SizedBox(
                            width: 40,
                          )
                        ],
                      )))),
          Positioned(
              top: vis ? 80 - temp : 50,
              child: MouseRegion(
                  onEnter: (_) => _onHoverMen(true),
                  onExit: (_) => _onHoverMen(false),
                  child: Visibility(
                    visible: _isHoveredMen,
                    child: ListMen(context, MediaQuery.of(context).size.width),
                  ))),
          Positioned(
              top: vis ? 80 - temp : 50,
              child: MouseRegion(
                  onEnter: (_) => _onHoverWomen(true),
                  onExit: (_) => _onHoverWomen(false),
                  child: Visibility(
                    visible: _isHoveredWomen,
                    child: ListWomen(
                      context,
                      MediaQuery.of(context).size.width,
                    ),
                  ))),
          Positioned(
              top: vis ? 80 - temp : 50,
              child: MouseRegion(
                  onEnter: (_) => _onHoverKids(true),
                  onExit: (_) => _onHoverKids(false),
                  child: Visibility(
                    visible: _isHoveredKids,
                    child: ListKids(
                      context,
                      MediaQuery.of(context).size.width,
                    ),
                  ))),
        ])));
  }
}
