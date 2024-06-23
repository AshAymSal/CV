import 'package:ecommernce/core/widgets/loading_widget.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/presentation/widgets/detalis_page/discription_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/detalis_page/colors_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/detalis_page/images_courosel_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/detalis_page/name_and_cost_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/detalis_page/rating_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/detalis_page/reviews_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/detalis_page/send_request_button_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/favorite_icon.dart';
import 'package:ecommernce/features/products/presentation/widgets/message_display_widget.dart';
import 'package:ecommernce/features/reviews/data/datasources/reviews_remote_datasource.dart';
import 'package:ecommernce/features/reviews/data/repositories/review_repository_imp.dart';
import 'package:ecommernce/features/reviews/domain/entities/review.dart';
import 'package:ecommernce/features/reviews/domain/usecases/get_all_reviews.dart';
import 'package:ecommernce/features/reviews/domain/usecases/get_best_review.dart';
import 'package:ecommernce/features/reviews/presentation/bloc/review/review_bloc.dart';
import 'package:ecommernce/features/reviews/presentation/bloc/review/review_events.dart';
import 'package:ecommernce/features/reviews/presentation/bloc/review/review_state.dart';
import 'package:ecommernce/features/reviews/presentation/pages/review_page.dart';
import 'package:ecommernce/core/network/network_info.dart';
import 'package:ecommernce/features/products/data/datasources/products_local_datasource.dart';
import 'package:ecommernce/features/products/data/datasources/products_remote_datasource.dart';
import 'package:ecommernce/features/products/data/repositories/product_repository_imp.dart';
import 'package:ecommernce/features/products/domain/usecases/check_product_is_liked.dart';
import 'package:ecommernce/features/products/domain/usecases/press_favorite_button.dart';
import 'package:ecommernce/features/products/presentation/bloc/one_product/one_product_bloc.dart';
import 'package:ecommernce/features/products/presentation/bloc/one_product/one_product_events.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class slDetalis extends StatelessWidget {
  Product pro;
  String id;
  slDetalis(this.pro, this.id, {Key? key}) : super(key: key);
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
      }),
      BlocProvider(create: (_) {
        return ReviewsBloc(
            getAllReviews: GetAllReviewsUsecase(
                repository: ReviewsRepositoryImpl(
                    // localDataSource: ProductsLocalDataSourceImpl(),
                    networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
                    remoteDataSource: ReviewsRemoteDataSourceImpl())),
            getBestreview: GetBestReviewUsecase(
                repository: ReviewsRepositoryImpl(
                    //   localDataSource: ProductsLocalDataSourceImpl(),
                    networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
                    remoteDataSource: ReviewsRemoteDataSourceImpl())));
      })
    ], child: sfDetalis(pro, id));
  }
}

class sfDetalis extends StatefulWidget {
  Product pro;
  String id;
  sfDetalis(this.pro, this.id, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return stateDetalis(pro, id);
  }
}

class stateDetalis extends State<sfDetalis> {
  //final GFBottomSheetController sheetController = GFBottomSheetController();
  Product? pro;
  String? id;
  Review? besReview;
  stateDetalis(this.pro, this.id);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (id != '-1') {
      BlocProvider.of<OneProductBloc>(context).add(CheckProductIsLikedEvent(
          product: widget.pro,
          userId: FirebaseAuth.instance.currentUser!.email!));
    }
    BlocProvider.of<ReviewsBloc>(context)
        .add(GetBestReviewEvent(widget.pro.id!));
    // detalisProvider
    //   .getRead(context)
    // .getBestReview(FirebaseAuth.instance.currentUser!.email!);
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(true);
          return true;
        },
        child: Scaffold(
            appBar: AppBar(),
            body: Container(
              height: totalHeight,
              color: Color(0xffd3faff),
              child: ListView(
                children: [
                  imagesCarousel(pro!.images!),
                  nameAndCost(pro!.name!, pro!.cost!),
                  colors(pro!.colors!),
                  description(pro!.description!),
                  SizedBox(height: 20),
                  rating(double.parse(pro!.rating!)),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Reviews',
                            style: TextStyle(fontSize: 16, fontFamily: "New"),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Text(
                              'See All Reivews',
                              style: TextStyle(fontSize: 11, fontFamily: "New"),
                              textAlign: TextAlign.end,
                            ),
                            onTap: () {
                              BlocProvider.of<ReviewsBloc>(context)
                                  .add(GetAllReviewsEvent(widget.pro.id!));
                              BlocListener<ReviewsBloc, ReviewsState>(
                                listener: (context, state) {
                                  if (state is LoadingReviewsState) {
                                    // LoadingWidget();
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return LoadingWidget();
                                        });
                                  } else if (state is LoadedReviewsState) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return slReviewsPage(
                                          reviews: state.allReviews);
                                    }));
                                  }
                                  Icon(Icons.favorite_border,
                                      color: Colors.black);
                                },
                                child: SizedBox(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  /* detalisProvider.getWatch(context).bestReview != null
                      ? reviews(context, pro!.id!,
                          detalisProvider.getRead(context).bestReview!)
                      : Container(
                          width: 250,
                          height: 75,
                        ),*/
                  BlocBuilder<ReviewsBloc, ReviewsState>(
                      builder: (context, state) {
                    if (state is LoadedBestReviewState) {
                      return state.bestReview.id != null
                          ? reviews(context, pro!.id!, state.bestReview)
                          : Container(
                              width: 250,
                              height: 75,
                            );
                    } else if (state is ErrorReviewsState) {
                      return MessageDisplayWidget(message: state.message);
                    }
                    return LoadingWidget();
                  }),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      sendRequest(context, pro!),
                      favoriteIcon(context, pro!),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )));
  }
}
