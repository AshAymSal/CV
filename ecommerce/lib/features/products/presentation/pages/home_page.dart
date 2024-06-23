import 'package:ecommernce/core/network/network_info.dart';
import 'package:ecommernce/core/widgets/loading_widget.dart';
import 'package:ecommernce/features/products/data/datasources/products_local_datasource.dart';
import 'package:ecommernce/features/products/data/datasources/products_remote_datasource.dart';
import 'package:ecommernce/features/products/data/repositories/product_repository_imp.dart';
import 'package:ecommernce/features/products/domain/usecases/get_populars.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_bloc.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/populars/populars_state.dart';
import 'package:ecommernce/features/products/presentation/pages/search_page.dart';
import 'package:ecommernce/features/products/presentation/widgets/home_page/category_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/home_page/most_popular_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/message_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class slhomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) {
        return PopularsBloc(
            getPopulars: GetPopularsUsecase(
                repository: ProductsRepositoryImpl(
                    localDataSource: ProductsLocalDataSourceImpl(),
                    networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
                    remoteDataSource: ProductsRemoteDataSourceImpl())));
      })
    ], child: sfhomepage());
  }
}

class sfhomepage extends StatefulWidget {
  sfhomepage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return statehomepage();
  }
}

class statehomepage extends State<sfhomepage> {
  //late List mostPopular;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PopularsBloc>(context).add(GetAllPopularsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 60,
      color: Color(0xffd3faff),
      child: Column(
        children: [
          //SizedBox(height: 100,),
          Container(
              // color: Colors.blue,
              height: 100,
              padding: EdgeInsets.only(top: 50, left: 10, right: 10),
              child: Text(
                "Ecommernce",
                style: TextStyle(
                  fontSize: 20,
                ),
              )),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              // color: Colors.white,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 300,
                    height: 50,
                  ),
                  Spacer(),
                  Icon(Icons.search)
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return slSearch();
              }));
            },
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text(
              "   Catigories",
              style: TextStyle(fontSize: 20, fontFamily: "New"),
            ),
            padding: EdgeInsets.only(right: 260),
          ),
          SizedBox(
            height: 30,
          ),
          Row(children: [
            SizedBox(
              width: 0,
            ), //Jackets // https://5.imimg.com/data5/NM/LX/MY-42532489/mens-black-jacket-500x500.jpg
            Catigory(context, "Jackets",
                "https://5.imimg.com/data5/NM/LX/MY-42532489/mens-black-jacket-500x500.jpg"),
            SizedBox(
              width: 0,
            ),
            Catigory(context, "T-Shirts",
                "https://img1.g-star.com/product/c_fill,f_auto,h_630,q_80/v1614686111/D14143-336-6484-M05/g-star-raw-raw-graphic-slim-t-shirt-black.jpg"),
            SizedBox(
              width: 0,
            ), // Jeans // https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgxTAikYMr7EqAyPmAQHS73iqcTAc4vGCNGQ&usqp=CAU
            Catigory(context, "Jeans",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgxTAikYMr7EqAyPmAQHS73iqcTAc4vGCNGQ&usqp=CAU"),
            SizedBox(
              width: 0,
            ), // Boots // https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKPx_Mkte5IqHtFMkU6pXUV_mMkBlE9hSEsg&usqp=CAU
            Catigory(context, "Boots",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKPx_Mkte5IqHtFMkU6pXUV_mMkBlE9hSEsg&usqp=CAU"),
          ]),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text(
              "Most Popular",
              style: TextStyle(fontSize: 18, fontFamily: "New"),
            ),
            padding: EdgeInsets.only(right: 225),
          ),
          SizedBox(
            height: 30,
          ),
          BlocBuilder<PopularsBloc, PopularsState>(builder: (context, state) {
            if (state is LoadingPopularsState) {
              return LoadingWidget();
            } else if (state is LoadedPopularsState) {
              return mostPupularList(
                  context: context, Populars: state.populars);
            } else if (state is ErrorPopularsState) {
              return MessageDisplayWidget(message: state.message);
            }
            return LoadingWidget();
          }),
        ],
      ),
    );
  }
}
