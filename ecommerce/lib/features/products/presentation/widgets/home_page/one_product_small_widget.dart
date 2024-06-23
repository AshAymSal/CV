import 'package:ecommernce/core/network/network_info.dart';
import 'package:ecommernce/features/products/data/datasources/products_local_datasource.dart';
import 'package:ecommernce/features/products/data/datasources/products_remote_datasource.dart';
import 'package:ecommernce/features/products/data/repositories/product_repository_imp.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/domain/usecases/check_product_is_liked.dart';
import 'package:ecommernce/features/products/domain/usecases/press_favorite_button.dart';
import 'package:ecommernce/features/products/presentation/bloc/one_product/one_product_bloc.dart';
import 'package:ecommernce/features/products/presentation/bloc/one_product/one_product_events.dart';
import 'package:ecommernce/features/products/presentation/pages/detalis_page.dart';
import 'package:ecommernce/features/products/presentation/widgets/favorite_icon.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class slOneProductWidgetHomePage extends StatelessWidget {
  Product? pro;
  slOneProductWidgetHomePage(this.pro, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) {
        return OneProductBloc(
            pressFavoriteButton: PressFavoriteButtonUsecase(
                repository: ProductsRepositoryImpl(
                    localDataSource: ProductsLocalDataSourceImpl(),
                    networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
                    remoteDataSource: ProductsRemoteDataSourceImpl())),
            checkProductIsLikedUsecase: CheckProductIsLikedUsecase(
                repository: ProductsRepositoryImpl(
                    localDataSource: ProductsLocalDataSourceImpl(),
                    networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
                    remoteDataSource: ProductsRemoteDataSourceImpl())));
      })
    ], child: sfOneProductWidgetHomePage(pro));
  }
}

class sfOneProductWidgetHomePage extends StatefulWidget {
  Product? pro;
  sfOneProductWidgetHomePage(this.pro, {Key? key}) : super(key: key);

  @override
  State<sfOneProductWidgetHomePage> createState() =>
      stateOneProductWidgetHomePage();
}

class stateOneProductWidgetHomePage extends State<sfOneProductWidgetHomePage> {
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      BlocProvider.of<OneProductBloc>(context).add(CheckProductIsLikedEvent(
          product: widget.pro!,
          userId: FirebaseAuth.instance.currentUser!.email!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return slDetalis(
              widget.pro!,
              FirebaseAuth.instance.currentUser == null
                  ? '-1'
                  : FirebaseAuth.instance.currentUser!.email!);
        })).then((value) {
          if (FirebaseAuth.instance.currentUser != null) {
            BlocProvider.of<OneProductBloc>(context).add(
                CheckProductIsLikedEvent(
                    product: widget.pro!,
                    userId: FirebaseAuth.instance.currentUser!.email!));
          }
        });
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            child: Container(
              child: Column(
                children: [
                  Container(
                      height: 100,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: Image.network(widget.pro!.images![0],
                            fit: BoxFit.fill),
                      )),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.white,
                    height: 50,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                                width: 60,
                                child: Center(
                                    child: Text(
                                  widget.pro!.name!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "New",
                                      fontSize: 11),
                                  textAlign: TextAlign.center,
                                ))),
                            SizedBox(height: 5),
                            Container(
                                width: 30,
                                child: Text(
                                  widget.pro!.cost! + "\$",
                                  style: TextStyle(
                                      fontSize: 12, fontFamily: "New"),
                                )),
                            //  SizedBox(width: 6),
                          ],
                        ),
                        Spacer(),
                        Container(
                          child: favoriteIcon(context, widget.pro!),
                          // alignment: Alignment.topRight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
