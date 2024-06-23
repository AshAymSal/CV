import 'package:ecommernce/core/network/network_info.dart';
import 'package:ecommernce/core/widgets/custom_drawer.dart';
import 'package:ecommernce/features/auth/auth_provider.dart';
import 'package:ecommernce/features/products/data/datasources/products_local_datasource.dart';
import 'package:ecommernce/features/products/data/datasources/products_remote_datasource.dart';
import 'package:ecommernce/features/products/data/repositories/product_repository_imp.dart';
import 'package:ecommernce/features/products/domain/usecases/get_favorites.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_bloc.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/purchase/purchase_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommernce/cache/sharedPreferences.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await sharedPreferences.init();
  runApp(slRunApp());
}

class slRunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<signInProvider>(
            create: (_) {
              return signInProvider(FirebaseAuth.instance);
            },
          ),
          StreamProvider(
            create: (context) {
              return context.read<signInProvider>().authStateChenges;
            },
            initialData: null,
          ),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) {
                return FavoritesBloc(
                    getAllFavorites: GetFavoritesUsecase(
                        repository: ProductsRepositoryImpl(
                            localDataSource: ProductsLocalDataSourceImpl(),
                            networkInfo:
                                NetworkInfoImpl(InternetConnectionChecker()),
                            remoteDataSource: ProductsRemoteDataSourceImpl())));
              }),
              BlocProvider(create: (_) {
                return PurchaseCubit();
              })
            ],
            child: MaterialApp(
                home: slUser(), debugShowCheckedModeBanner: false)));
  }
}

class slUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return CustomDrawer(
      //controller: _drawerController,
      //mainScreen: slMainPage(_drawerController),
      //menuScreen: slSettingsPage(_drawerController),
      showShadow: false,
      angle: 0.0,
      borderRadius: 30,
      slideWidth: MediaQuery.of(context).size.width *
          (CustomDrawer.isRTL(context) ? 0.45 : 0.70),
    );
  }
}
