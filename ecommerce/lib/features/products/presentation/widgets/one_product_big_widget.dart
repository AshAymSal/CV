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

class slOneProduct extends StatelessWidget {
  Product? pro;
  slOneProduct(this.pro, {Key? key}) : super(key: key);
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
    ], child: sfOneProduct(pro));
  }
}

class sfOneProduct extends StatefulWidget {
  Product? pro;
  sfOneProduct(this.pro, {Key? key}) : super(key: key);

  @override
  State<sfOneProduct> createState() => stateOneProduct();
}

class stateOneProduct extends State<sfOneProduct> {
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
      child: Container(
          height: 150,
          margin: EdgeInsets.symmetric(horizontal: 60),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                child: Row(
                  children: [
                    Container(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                          ),
                          child: Image.network(widget.pro!.images![0],
                              fit: BoxFit.fitHeight),
                        )),
                    //Spacer(),
                    Container(
                      width: 120,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            height: 50,
                            child: Container(
                                child: favoriteIcon(context, widget.pro!)),
                          ),
                          Container(
                            height: 20,
                            child: Center(
                                child: Text(
                              widget.pro!.name!,
                              style: TextStyle(fontSize: 16, fontFamily: "New"),
                            )),
                          ),
                          Container(
                            height: 50,
                            child: Center(
                                child: Text("\$" + widget.pro!.cost!,
                                    style: TextStyle(
                                        fontSize: 22, fontFamily: "New"))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
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
    );
  }
}
