import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase.dart';
import 'manegerProductAddOrEdit.dart';
import 'model/product.dart';

class slManegerAllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return sfManegerAllProducts();
  }
}

class sfManegerAllProducts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return stateManegerAllProducts();
  }
}

class stateManegerAllProducts extends State<sfManegerAllProducts> {
  @override
  Widget build(BuildContext context) {
    var model2 = Provider.of<firebase>(context, listen: true);
    return FutureProvider<List<product>>(
        create: (BuildContext context) {
          return context.read<firebase>().getAll();
        },
        initialData: [],
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return slManegerProductDetalis(0, null);
              })).then((value) {
                model2.refreshAll();
                setState(() {});
              });
            },
            child: Icon(Icons.add),
          ),
          body: sfManegerAllProductsProvider(),
        ));
  }
}

class sfManegerAllProductsProvider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return stateManegerAllProductsProvider();
  }
}

class stateManegerAllProductsProvider
    extends State<sfManegerAllProductsProvider> {
  @override
  Widget build(BuildContext context) {
    var model2 = Provider.of<firebase>(context, listen: true);
    context.watch<List<product>>();
    TextEditingController sch = TextEditingController();

    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    return Container(
      height: totalHeight,
      width: totalWidth,
      color: Color(0xffd3faff),
      child: Column(
        children: [
          SizedBox(
            height: totalHeight / 16,
          ),
          Container(
            child: TextField(
              controller: sch,
              onChanged: (value) async {
                CollectionReference ref =
                    FirebaseFirestore.instance.collection("products");
                QuerySnapshot qssh =
                    await ref.where("name", isEqualTo: value).get();
              },
            ),
          ),
          Container(
            height: totalHeight - (totalHeight / 8),
            child: ListView.builder(
                itemCount: model2.allProducts.length,
                itemBuilder: (context, index) {
                  final prodct = model2.allProducts[index];
                  product pro = product(
                      name: prodct.name,
                      id: prodct.id,
                      type: prodct.type,
                      times: prodct.times,
                      cost: prodct.cost,
                      description: prodct.description,
                      images: prodct.images);
                  return GestureDetector(
                    child: Container(
                        height: (MediaQuery.of(context).size.height - 146) / 4,
                        margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 6),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          2 /
                                          3 *
                                          2,
                                      height:
                                          (MediaQuery.of(context).size.height -
                                                  146) /
                                              4,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                        ),
                                        child: Image.network(pro.images![0],
                                            fit: BoxFit.fitHeight),
                                      )),
                                  // Container(
                                  //     color: Colors.blue,
                                  //     width: MediaQuery
                                  //         .of(context)
                                  //         .size
                                  //         .width / 2 / 3 * 2),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                            2 /
                                            3 *
                                            2 -
                                        9,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height: ((MediaQuery.of(context)
                                                            .size
                                                            .height -
                                                        146) /
                                                    4 /
                                                    4) -
                                                10),
                                        Container(
                                          height: ((MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      146) /
                                                  4 /
                                                  3) -
                                              10,
                                          child: Center(
                                              child: Text(
                                            pro.name!,
                                            style: TextStyle(fontSize: 20),
                                          )),
                                        ),
                                        Container(
                                          height: ((MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      146) /
                                                  4 /
                                                  3) -
                                              8,
                                          child: Center(
                                              child: Text("\$" + pro.cost!,
                                                  style:
                                                      TextStyle(fontSize: 30))),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return slManegerProductDetalis(1, pro);
                      })).then((value) {
                        model2.refreshAll();
                        setState(() {});
                      });
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
