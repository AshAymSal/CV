import 'package:ecommernce/core/network/network_info.dart';
import 'package:ecommernce/core/widgets/loading_widget.dart';
import 'package:ecommernce/features/products/data/datasources/products_local_datasource.dart';
import 'package:ecommernce/features/products/data/datasources/products_remote_datasource.dart';
import 'package:ecommernce/features/products/data/repositories/product_repository_imp.dart';
import 'package:ecommernce/features/products/domain/usecases/get_products_by_search.dart';
import 'package:ecommernce/features/products/presentation/bloc/search/search_bloc.dart';
import 'package:ecommernce/features/products/presentation/bloc/search/search_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/search/search_state.dart';
import 'package:ecommernce/features/products/presentation/widgets/message_display_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/search_page/search_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class slSearch extends StatelessWidget {
  const slSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) {
        return SearchBloc(
            getProductsBySearch: GetProductsBySearchUsecase(
                repository: ProductsRepositoryImpl(
                    localDataSource: ProductsLocalDataSourceImpl(),
                    networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
                    remoteDataSource: ProductsRemoteDataSourceImpl())));
      })
    ], child: sfSearch());
  }
}

class sfSearch extends StatefulWidget {
  const sfSearch({Key? key}) : super(key: key);

  @override
  State<sfSearch> createState() => _stateSearch();
}

class _stateSearch extends State<sfSearch> {
  late TextEditingController text;
  late String query;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text = TextEditingController();
    query = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          height: 895,
          color: Color(0xffd3faff),
          child: Column(children: [
            SizedBox(height: 80),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              // color: Colors.white,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (v) {
                        //setState(() {
                        //query = v;
                        //});
                        BlocProvider.of<SearchBloc>(context)
                            .add(GetProductsBySearchEvent(searchText: v));
                      },
                      controller: text,
                      maxLines: 1,
                      autofocus: true,
                      //controller: email,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
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
            Container(
              height: 600,
              child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                if (state is LoadingSearchState) {
                  return LoadingWidget();
                } else if (state is LoadedSearchState) {
                  return ProuctsBySearch(
                      productsBySearch: state.productsBySearch);
                } else if (state is ErrorSearchState) {
                  return MessageDisplayWidget(message: state.message);
                }
                return LoadingWidget();
              }),

              /*FutureBuilder<List>(
                future:
                    searchProvider.getRead(context).getProductsBySearch(query),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            List products = snapshot.data!;
                            final pro = products[index];
                            return slOneProduct(pro);
                          });
                  }
                },
              ),*/
            )
          ])),
    ));
  }
}
