import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web/features/language/lang.dart';
import 'package:flutter_web/features/auth/data/datasources/Auth_remote_datasource.dart';
import 'package:flutter_web/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:flutter_web/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_web/features/auth/presentation/bloc/product/auth_bloc.dart';
import 'package:flutter_web/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_web/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:flutter_web/features/cart/data/repositories/cart_repository_imp.dart';
import 'package:flutter_web/features/cart/domain/entities/cart.dart';
import 'package:flutter_web/features/cart/domain/usecases/add_cart_usecase.dart';
import 'package:flutter_web/features/cart/domain/usecases/cart_usecase.dart';
import 'package:flutter_web/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter_web/features/cart/presentation/pages/checkout_page.dart';
import 'package:flutter_web/features/cart/presentation/pages/show_user_carts.dart';
import 'package:flutter_web/features/language/language_cubit.dart';
import 'package:flutter_web/features/products/data/datasources/products_remote_datasource.dart';
import 'package:flutter_web/features/products/data/repositories/product_repository_imp.dart';
import 'package:flutter_web/features/products/domain/entities/product.dart';
import 'package:flutter_web/features/products/domain/usecases/add_product_usecase.dart';
import 'package:flutter_web/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:flutter_web/features/products/domain/usecases/get_categories_usecase.dart';
import 'package:flutter_web/features/products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:flutter_web/features/products/domain/usecases/get_products_usecase.dart';
import 'package:flutter_web/features/products/domain/usecases/update_product_usecase.dart';
import 'package:flutter_web/features/products/presentation/bloc/category/category_bloc.dart';
import 'package:flutter_web/features/products/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_web/features/products/presentation/pages/product_detalis_page.dart';
import 'package:flutter_web/responsive/main_page_mobile.dart';
import 'package:flutter_web/responsive/main_page_web.dart';
import 'package:flutter_web/responsive/responsive_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(
                    loginUseCase: LoginUseCase(AuthRepositoryImpl(
                        remoteDataSource: AuthRemoteDataSource())),
                  )),
          BlocProvider(
              create: (context) => CartBloc(
                    addCartUseCase: AddCartUsecase(CartRepositoryImpl(
                        remoteDataSource: CartRemoteDataSource())),
                    getUserUseCase: GetUserCartsCase(CartRepositoryImpl(
                        remoteDataSource: CartRemoteDataSource())),
                  )),
          BlocProvider(create: (_) => LanguageCubit('en'))
        ],
        child: BlocBuilder<LanguageCubit, String>(builder: (context, locale) {
          return MaterialApp(
              title: 'Flutter E-Commerce App',
              locale: Locale(locale), // Set default locale
              supportedLocales: const [
                Locale('en', ''), // English
                Locale('ar', ''), // Spanish
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate, // Our custom delegate
                GlobalMaterialLocalizations.delegate, // Flutter's localization
                GlobalWidgetsLocalizations.delegate, // Widgets localization
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: '/',
              onGenerateRoute: (settings) {
                if (settings.name == '/') {
                  return MaterialPageRoute(
                      builder: (context) => const ResponsiveMainPage(
                          mobile: MainPageMobile(), web: MainPageWeb()));
                } else if (settings.name == '/login') {
                  return MaterialPageRoute(builder: (context) => LoginScreen());
                } else if (settings.name == '/detalis') {
                  final Product product = settings.arguments as Product;
                  return MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(product: product));
                } else if (settings.name == '/userCartsList') {
                  return MaterialPageRoute(
                      builder: (context) => (CartListScreen(
                            userId: settings.arguments as int,
                          )));
                } else if (settings.name == '/checkoutPage') {
                  return MaterialPageRoute(
                      builder: (context) => (CheckoutPage(
                            cartItems: settings.arguments as List<cartitem>,
                          )));
                }
                return null;
              },
              home: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => ProductBloc(
                              getProductsUseCase: GetProductsUseCase(
                                  ProductsRepositoryImpl(
                                      remoteDataSource:
                                          ProductsRemoteDataSource())),
                              getProductByIdUseCase: GetProductByIdUseCase(
                                  ProductsRepositoryImpl(
                                      remoteDataSource:
                                          ProductsRemoteDataSource())),
                              addProductUseCase: AddProductUseCase(
                                  ProductsRepositoryImpl(
                                      remoteDataSource:
                                          ProductsRemoteDataSource())),
                              updateProductUseCase: UpdateProductUseCase(
                                  ProductsRepositoryImpl(
                                      remoteDataSource:
                                          ProductsRemoteDataSource())),
                              deleteProductUseCase: DeleteProductUseCase(
                                  ProductsRepositoryImpl(
                                      remoteDataSource:
                                          ProductsRemoteDataSource())),
                            )),
                    BlocProvider(
                        create: (context) => CategoryBloc(
                              getCategoriesUseCase: GetCategoriesUseCase(
                                  ProductsRepositoryImpl(
                                      remoteDataSource:
                                          ProductsRemoteDataSource())),
                            )),
                  ],
                  child: const Scaffold(
                    body: ResponsiveMainPage(
                        mobile: MainPageMobile(), web: MainPageWeb()),
                  )));
        }));
  }
}

/*
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nested Drawer Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nested Drawer Example'),
        ),
        drawer: Container(
          child: NestedDrawer(),
          height: MediaQuery.of(context).size.height,
          width: 290,
        ),
        body: Center(child: Text('Main Content Area')),
      ),
    );
  }
}

class NestedDrawer extends StatefulWidget {
  @override
  _NestedDrawerState createState() => _NestedDrawerState();
}

class _NestedDrawerState extends State<NestedDrawer> {
  List<String> mainMenu = ['Item 1', 'Item 2', 'Item 3'];
  Map<String, List<String>> subMenu = {
    'Item 1': ['Sub Item 1.1', 'Sub Item 1.2', 'Sub Item 1.3'],
    'Item 2': ['Sub Item 2.1', 'Sub Item 2.2'],
    'Item 3': ['Sub Item 3.1'],
  };

  Map<String, List<String>> subSubMenu = {
    'Sub Item 1.1': ['SubSub Item 1.1.1', 'SubSub Item 1.1.2'],
    'Sub Item 1.2': ['SubSub Item 1.2.1'],
    'Sub Item 2.1': ['SubSub Item 2.1.1'],
  };

  String currentSubMenu = "Item 1";
  String currentSubSubMenu = "Sub Item 1.1";
  // bool isShowingSubMenu = false;
  //bool isShowingSubSubMenu = false;

  bool vismain = true;
  bool vissub = true;
  bool vissubsub = true;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: 290,
        color: Colors.white,
        child: _buildSubSubMenu(currentSubSubMenu),
      ),
      AnimatedPositioned(
        left: vissub ? 0 : 290,
        duration: Duration(milliseconds: 200),
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: 290,
            color: Colors.white,
            child: _buildSubMenu(currentSubMenu)),
      ),
      AnimatedPositioned(
          left: vismain ? 0 : 290,
          duration: Duration(milliseconds: 200),
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: 290,
              color: Colors.white,
              child: _buildMainMenu())),
    ]);
  }

  Widget _buildMainMenu() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Main Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        for (String item in mainMenu)
          ListTile(
            title: Text(item),
            onTap: () {
              setState(() {
                currentSubMenu = item;
                //  currentMenu = item; // Navigate to the submenu
                vismain = false;
                vissub = true;
              });
            },
          ),
      ],
    );
  }

  Widget _buildSubMenu(String menu) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    vismain = true;
                    //vissub = false;
                    // Go back to main menu
                  });
                },
              ),
              SizedBox(width: 10),
              Text(
                'Sub Menu of $menu',
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ],
          ),
        ),
        for (String subItem in subMenu[menu]!)
          ListTile(
            title: Text(subItem),
            onTap: () {
              setState(() {
                currentSubSubMenu = subItem;
                vissub = false;

                //currentSubMenu = subItem; // Navigate to the sub-submenu
              });
            },
          ),
      ],
    );
  }

  Widget _buildSubSubMenu(String subMenuItem) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    vissub = true;
                    //  currentSubMenu = null; // Go back to sub menu
                  });
                },
              ),
              SizedBox(width: 10),
              Text(
                'Sub-Sub Menu of $subMenuItem',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        for (String subSubItem in subSubMenu[subMenuItem]!)
          ListTile(
            title: Text(subSubItem),
            onTap: () {
              // Perform action here
              Navigator.pop(context); // Close the drawer after action
            },
          ),
      ],
    );
  }
}
*/
