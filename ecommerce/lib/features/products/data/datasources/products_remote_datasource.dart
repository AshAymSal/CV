import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommernce/features/products/data/models/product_model.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getPopular();
  Future<List<ProductModel>> getFavorites({required String userId});
  Future<List<ProductModel>> getProductsByCategory({required String category});
  Future<List<ProductModel>> getProductsBySearch({required String searchText});
  Future<Unit> removeFromFavoritesAsId(int id);
  Future<bool> pressFavoriteButton(
      {required Product product,
      required bool isLiked,
      required String userId});
  Future<bool> checkProductIsLiked(
      {required String userId, required Product product});
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  ProductsRemoteDataSourceImpl();

  @override
  Future<List<ProductModel>> getFavorites({String? userId}) async {
    CollectionReference ref = FirebaseFirestore.instance.collection("products");
    CollectionReference ref2 = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("favorites");
    QuerySnapshot qsshid = await ref2.get(); // هان برجع كبشة documents
    List<QueryDocumentSnapshot> listid = qsshid.docs; // وهان بنحطهم ك list
    print(userId!);

    List<String> ids = [];
    listid.forEach((elementt) {
      String id = elementt["id"];
      ids.add(id);
    });
    List<ProductModel> re = await gdd(ids, userId);
    print("iddddss" + re.length.toString());
    return re;

    //print(favorites.length);
  }

  Future<List<ProductModel>> gdd(List ids, String userId) async {
    List<ProductModel> favorites = [];
    CollectionReference ref = FirebaseFirestore.instance.collection("products");
    CollectionReference ref2 = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("favorites");

    for (var elemente in ids) {
      QuerySnapshot qsshpro = await ref.where("id", isEqualTo: elemente).get();
      if (qsshpro.docs.isEmpty) {
        QuerySnapshot qsshproo =
            await ref2.where("id", isEqualTo: elemente).get();
        String id = qsshproo.docs[0]["fav id"];
        ref2.doc(id).delete();
      } else {
        final element = qsshpro.docs[0];
        ProductModel toAdd = ProductModel(
          name: element["name"],
          id: element["id"],
          type: element["type"],
          times: element["times"],
          cost: element["cost"],
          images: element["images"],
          description: element["description"],
          sizes: element['sizes'],
          colors: element['colors'],
          rating: element['rating'],
        );
        favorites.add(toAdd);
      }
    }
    return favorites;
  }

  @override
  Future<bool> pressFavoriteButton(
      {required String userId,
      required bool isLiked,
      required Product product}) async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("favorites");
    if (isLiked) {
      var s = await ref.where("id", isEqualTo: product.id!).get();
      QueryDocumentSnapshot qd = s.docs[0];
      var del = await ref.doc(qd.id).delete();
      // icon = Icons.favorite_border;
      //    iconColor = Colors.black;
      return false;
      //  favoriteProvider.getRead(context).removeFromFavoritesAsId(pro);
    } else {
      var s = await ref.where("id", isEqualTo: product.id!).get();
      var ad = await ref.add({
        "id": product.id!,
      });
      var upd = await ref.doc(ad.id).update({"fav id": ad.id});
      //icon = Icons.favorite;
      //    iconColor = Colors.red;
      return true;
      //  favoriteProvider.getRead(context).addToFavorites(pro);
      // notifyListeners();
    }
  }

  @override
  Future<List<ProductModel>> getPopular() async {
    List<ProductModel> mostPopular = [];
    CollectionReference ref = FirebaseFirestore.instance.collection("products");
    QuerySnapshot qssh = await ref
        .orderBy("times", descending: true)
        .limit(5)
        .get(); // هان برجع كبشة documents
    List<QueryDocumentSnapshot> listdocs = qssh.docs; // وهان بنحطهم ك list
    listdocs.forEach((element) {
      ProductModel toAdd = ProductModel(
          name: element["name"],
          id: element["id"],
          type: element["type"],
          times: element["times"],
          cost: element["cost"],
          images: element["images"],
          description: element["description"],
          sizes: element['sizes'],
          colors: element['colors'],
          rating: element['rating']);
      mostPopular.add(toAdd);
      /*try {
        notifyListeners();
      } catch (e) {
        print(e);
      }*/
    });
    return mostPopular;
  }

  @override
  Future<Unit> removeFromFavoritesAsId(int id) {
    // TODO: implement removeFromFavoritesAsId
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(
      {required String category}) async {
    List<ProductModel> products = [];
    CollectionReference ref1 =
        FirebaseFirestore.instance.collection("products");
    QuerySnapshot qssh = await ref1.where("type", isEqualTo: category).get();
    List<QueryDocumentSnapshot> listdocs = qssh.docs; // وهان بنحطهم ك list
    //print(category);

    listdocs.forEach((element) {
      ProductModel toAdd = ProductModel(
        name: element["name"],
        id: element["id"],
        type: element["type"],
        times: element["times"],
        cost: element["cost"],
        images: element["images"],
        description: element["description"],
        sizes: element['sizes'],
        colors: element['colors'],
        rating: element['rating'],
      );
      products.add(toAdd);
    });
    return products;
  }

  @override
  Future<bool> checkProductIsLiked(
      {required String userId, required Product product}) async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("favorites");
    var list = await ref.where("id", isEqualTo: product.id!).get();
    if (list.size > 0) {
      // icon = Icons.favorite;
      //iconColor = Colors.red;
      return true;
    } else {
      // icon = Icons.favorite_border;
      // iconColor = Colors.black;
      return false;
    }
  }

  @override
  Future<List<ProductModel>> getProductsBySearch(
      {required String searchText}) async {
    List<ProductModel> products = [];
    CollectionReference ref1 =
        FirebaseFirestore.instance.collection("products");
    if (!searchText.isEmpty) {
      QuerySnapshot qssh = await ref1
          .where("name",
              isGreaterThanOrEqualTo: searchText,
              isLessThan: searchText.substring(0, searchText.length - 1) +
                  String.fromCharCode(
                      searchText.codeUnitAt(searchText.length - 1) + 1))
          .get();
      List<QueryDocumentSnapshot> listdocs = qssh.docs; // وهان بنحطهم ك list
      listdocs.forEach((element) async {
        ProductModel toAdd = ProductModel(
          name: element["name"],
          id: element["id"],
          type: element["type"],
          times: element["times"],
          cost: element["cost"],
          images: element["images"],
          description: element["description"],
          sizes: element['sizes'],
          colors: element['colors'],
          rating: element['rating'],
        );
        products.add(toAdd);
      });
    }
    return products;
  }
}
