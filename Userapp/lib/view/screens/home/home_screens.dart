import 'package:flutter/material.dart';
import 'package:flutter_grocery/data/model/response/config_model.dart';
import 'package:flutter_grocery/helper/responsive_helper.dart';
import 'package:flutter_grocery/helper/route_helper.dart';
import 'package:flutter_grocery/localization/language_constrants.dart';
import 'package:flutter_grocery/provider/auth_provider.dart';
import 'package:flutter_grocery/provider/banner_provider.dart';
import 'package:flutter_grocery/provider/category_provider.dart';
import 'package:flutter_grocery/provider/localization_provider.dart';
import 'package:flutter_grocery/provider/product_provider.dart';
import 'package:flutter_grocery/provider/splash_provider.dart';
import 'package:flutter_grocery/provider/wishlist_provider.dart';
import 'package:flutter_grocery/utill/color_resources.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/styles.dart';
import 'package:flutter_grocery/view/base/footer_view.dart';
import 'package:flutter_grocery/view/base/title_widget.dart';
import 'package:flutter_grocery/view/base/web_app_bar/web_app_bar.dart';
import 'package:flutter_grocery/view/screens/home/widget/banners_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/category_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/home_item_view.dart';
import 'package:flutter_grocery/view/screens/home/widget/product_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  //Branches branch;

  // HomeScreen(this.branch);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _loadData(BuildContext context, bool reload) async {
    Provider.of<ProductProvider>(context, listen: false)
        .getLatestProductListByBranch(
      context,
      '1',
      true,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );
    Provider.of<CategoryProvider>(context, listen: false).getCategoryList(
      context,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
      reload,
    );

    Provider.of<BannerProvider>(context, listen: false)
        .getBannerList(context, reload);

    await Provider.of<ProductProvider>(context, listen: false).getDailyNeeds(
      context,
      '1',
      true,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );

    Provider.of<ProductProvider>(context, listen: false).getPopularProductList(
      context,
      '1',
      true,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );

    /*Provider.of<ProductProvider>(context, listen: false).getLatestProductList(
      context,
      '1',
      true,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .languageCode,
    );*/

    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      await Provider.of<WishListProvider>(context, listen: false)
          .getWishList(context);
    }
  }

  @override
  void initState() {
    _loadData(context, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print("selected :" + widget.branch.name);
    final ScrollController _scrollController = ScrollController();

    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<ProductProvider>(context, listen: false).offset = 1;
        Provider.of<ProductProvider>(context, listen: false).popularOffset = 1;
        await _loadData(context, true);
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context)
            ? PreferredSize(
                child: WebAppBar(), preferredSize: Size.fromHeight(120))
            : null,
        body: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 1170,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: ResponsiveHelper.isDesktop(context)
                              ? MediaQuery.of(context).size.height - 400
                              : MediaQuery.of(context).size.height),
                      child: Column(children: [
                        //Text(widget.branch.name),
                        /* Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                              child: Text(
                                  getTranslated('select_branch', context),
                                  style: poppinsMedium.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_LARGE)),
                            ),
                          ],
                        ),*/
                        /* Center(
                          child: SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              physics: BouncingScrollPhysics(),
                              itemCount: _branches.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: Dimensions.PADDING_SIZE_SMALL),
                                  child: InkWell(
                                    onTap: () {
                                      try {
                                        /*order.setBranchIndex(index);
                                        double.parse(_branches[index].latitude);
                                        _setMarkers(index);*/
                                        Provider.of<SplashProvider>(context,
                                                listen: false)
                                            .setSelectedBranch(
                                                _branches[index]);
                                      } catch (e) {}
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL,
                                          horizontal:
                                              Dimensions.PADDING_SIZE_SMALL),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _branches[index].id ==
                                                Provider.of<SplashProvider>(
                                                        context,
                                                        listen: true)
                                                    .selectedBranch
                                                    .id
                                            ? Theme.of(context).primaryColor
                                            : ColorResources.getBackgroundColor(
                                                context),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(_branches[index].name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: poppinsMedium.copyWith(
                                            color: _branches[index].id ==
                                                    Provider.of<SplashProvider>(
                                                            context,
                                                            listen: true)
                                                        .selectedBranch
                                                        .id
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .color,
                                          )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
*/
                        Consumer<BannerProvider>(
                            builder: (context, banner, child) {
                          return banner.bannerList == null
                              ? BannersView()
                              : banner.bannerList.length == 0
                                  ? SizedBox()
                                  : BannersView();
                        }),

                        // Category
                        Consumer<CategoryProvider>(
                            builder: (context, category, child) {
                          return category.categoryList == null
                              ? CategoryView()
                              : category.categoryList.length == 0
                                  ? SizedBox()
                                  : CategoryView();
                        }),

                        // Category
                        SizedBox(
                            height: ResponsiveHelper.isDesktop(context)
                                ? Dimensions.PADDING_SIZE_LARGE
                                : 0),

                        TitleWidget(
                            title: getTranslated('daily_needs', context),
                            onTap: () {
                              Navigator.pushNamed(context,
                                  RouteHelper.getHomeItemRoute('daily_needs'));
                            }),
                        Consumer<ProductProvider>(
                            builder: (context, product, child) {
                          return product.dailyItemList == null
                              ? HomeItemView(isDailyItem: true)
                              : product.dailyItemList.length == 0
                                  ? SizedBox()
                                  : HomeItemView(isDailyItem: true);
                        }),

                        TitleWidget(
                            title: getTranslated('popular_item', context),
                            onTap: () {
                              Navigator.pushNamed(context,
                                  RouteHelper.getHomeItemRoute('popular_item'));
                            }),

                        Consumer<ProductProvider>(
                            builder: (context, product, child) {
                          return product.latestProductListByBranch == null
                              ? HomeItemView(isDailyItem: false)
                              : product.latestProductListByBranch.length == 0
                                  ? SizedBox()
                                  : HomeItemView(isDailyItem: false);
                        }),

                        ResponsiveHelper.isMobilePhone()
                            ? SizedBox(height: 10)
                            : SizedBox.shrink(),
                        TitleWidget(
                            title: getTranslated('latest_items', context)),
                        ProductView(scrollController: _scrollController),
                      ]),
                    ),
                  ),
                ),
                ResponsiveHelper.isDesktop(context) ? FooterView() : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
