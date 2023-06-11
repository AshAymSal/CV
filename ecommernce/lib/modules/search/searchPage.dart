import 'package:ecommernce/modules/oneProduct/oneProductWidgets.dart';
import 'package:ecommernce/modules/search/searchProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class slSearch extends StatelessWidget {
  const slSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<searchProvider>(
          create: (_) {
            return searchProvider();
          },
        )
      ],
      child: sfSearch(),
    );
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
                        setState(() {
                          query = v;
                        });
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
              child: FutureBuilder<List>(
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
              ),
            )
          ])),
    ));
  }
}
