import 'package:ecommernce/core/network/network_info.dart';
import 'package:ecommernce/core/widgets/loading_widget.dart';
import 'package:ecommernce/features/products/data/datasources/products_local_datasource.dart';
import 'package:ecommernce/features/products/data/datasources/products_remote_datasource.dart';
import 'package:ecommernce/features/products/data/repositories/product_repository_imp.dart';
import 'package:ecommernce/features/products/domain/usecases/get_favorites.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_bloc.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/favortites/favorites_state.dart';
import 'package:ecommernce/features/products/presentation/widgets/favorites_page/favorites_list_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/message_display_widget.dart';
import 'package:ecommernce/modules/favorites/favoriteWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class slFavoritePage extends StatelessWidget {
  var f = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return sfFavoritePage();
  }
}

class sfFavoritePage extends StatefulWidget {
  sfFavoritePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return stateFavoritePage();
  }
}

class stateFavoritePage extends State<sfFavoritePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FavoritesBloc>(context).add(GetAllFavoritesEvent(
        userId: FirebaseAuth.instance.currentUser!.email!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Favorites"),
        ),
        body: /*Container(
        //height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffd3faff),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    40 -
                    34,
                color: Color(0xffd3faff),
                child: FirebaseAuth.instance.currentUser != null
                    ? favoriteListWidget(context)
                    : Center(
                        child: Text(
                        "You must to log in",
                        style: TextStyle(fontSize: 20),
                      )))
          ],
        ),
      ),*/
            BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
          if (state is LoadingFavoritesState) {
            return LoadingWidget();
          } else if (state is LoadedFavoritesState) {
            return favoriteListWidget(
                context: context, favorites: state.favorites);
          } else if (state is ErrorFavoritesState) {
            return MessageDisplayWidget(message: state.message);
          }
          return LoadingWidget();
        }));
  }
}
