import 'package:ecommernce/core/network/network_info.dart';
import 'package:ecommernce/features/products/data/datasources/products_local_datasource.dart';
import 'package:ecommernce/features/products/data/datasources/products_remote_datasource.dart';
import 'package:ecommernce/features/products/data/repositories/product_repository_imp.dart';
import 'package:ecommernce/features/products/domain/usecases/get_products_by_category.dart';
import 'package:ecommernce/features/products/presentation/bloc/category/category_bloc.dart';
import 'package:ecommernce/features/products/presentation/bloc/category/category_events.dart';
import 'package:ecommernce/features/products/presentation/widgets/category_page/products_by_category_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class slCategory extends StatelessWidget {
  String Catigory;
  slCategory(this.Catigory, {Key? key}) : super(key: key);
  @override
  Widget build(Object context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) {
        return CategoryBloc(
            getProductsByCategory: GetProductsByCategoryUsecase(
                repository: ProductsRepositoryImpl(
                    localDataSource: ProductsLocalDataSourceImpl(),
                    networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
                    remoteDataSource: ProductsRemoteDataSourceImpl())));
      })
    ], child: sfCatigory(Catigory));
  }
}

class sfCatigory extends StatefulWidget {
  String catigoryName;

  sfCatigory(this.catigoryName, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return catigoryState();
  }
}

class catigoryState extends State<sfCatigory> {
  late String catigorySearch;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.catigoryName == "Jackets") {
      catigorySearch = "jacket";
    } else if (widget.catigoryName == "T-Shirts") {
      catigorySearch = "tshirt";
    } else if (widget.catigoryName == "Jeans") {
      catigorySearch = "jeans";
    } else {
      catigorySearch = "boots";
    }
    //return catigoryby("boots", context);
    BlocProvider.of<CategoryBloc>(context)
        .add(GetProductsByCategoryEvent(category: catigorySearch));
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    CollectionReference ref1 =
        FirebaseFirestore.instance.collection("products");
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xffd3faff),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      top: totalHeight / 8 / 2.5,
                      bottom: totalHeight / 120,
                      left: totalWidth / 40),
                  child: IconButton(
                    iconSize: 30,
                    icon: Icon(Icons.arrow_back_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ]),
            Container(
              child: Text(
                widget.catigoryName,
                style: TextStyle(fontSize: 25, fontFamily: "New"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height - 156,
                child: catigoryby(catigorySearch, context))
          ],
        ),
      ),
    );
  }
}
