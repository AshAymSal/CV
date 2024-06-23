import 'package:ecommernce/core/network/network_info.dart';
import 'package:ecommernce/core/widgets/loading_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/message_display_widget.dart';
import 'package:ecommernce/features/purchase/data/datasourcses/purchase_remote_datasource.dart';
import 'package:ecommernce/features/purchase/data/repositories/purchase_repository_impl.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:ecommernce/features/purchase/domain/usecases/get_sales.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/sales/sales_bloc.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/sales/sales_events.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/sales/sales_state.dart';
import 'package:ecommernce/features/purchase/presentation/widgets/sales_page/sales_list_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class slSalePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) {
        return SalesBloc(
            getSales: GetSalesUsecase(
                repository: PurchaseRepositoryImpl(
                    networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
                    remoteDataSource: PurchaseRemoteDataSourceImpl())));
      })
    ], child: sfSalePage());
  }
}

class sfSalePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return stateSalePage();
  }
}

class stateSalePage extends State<sfSalePage> {
  late List<Purchase> sales;

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      BlocProvider.of<SalesBloc>(context).add(
          GetSalesEvent(userId: FirebaseAuth.instance.currentUser!.email!));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // sales = salesProvider.getWatch(context).sales;
    //print(sales.length);

    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sales History"),
        ),
        body: Container(
          height: totalHeight,
          width: totalWidth,
          color: Color(0xffd3faff),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                height: totalHeight / 1.249,
                child: FirebaseAuth.instance.currentUser != null
                    ? BlocBuilder<SalesBloc, SalesState>(
                        builder: (context, state) {
                        if (state is LoadedSalesState) {
                          return SalesListWidget(totalWidth, totalHeight,
                              sales: sales);
                        } else if (state is ErrorSalesState) {
                          return MessageDisplayWidget(message: state.message);
                        }
                        return LoadingWidget();
                      })
                    : Center(
                        child: Text(
                        "You must to log in",
                        style: TextStyle(fontSize: 20),
                      )),
              ),
            ],
          ),
        ));
  }
}
