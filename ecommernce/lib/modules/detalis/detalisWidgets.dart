import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/model/product.dart';
import 'package:ecommernce/model/purchase.dart';
import 'package:ecommernce/model/review.dart';
import 'package:ecommernce/modules/reviews/reviewsPage.dart';
import 'package:ecommernce/modules/signIn/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:ecommernce/modules/detalis/detalisProvider.dart';
import 'package:ecommernce/modules/checkout/puchaseProvider.dart';
import 'package:getwidget/getwidget.dart';

Widget nameAndCost(String name, String cost) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    height: 50,
    child: Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: TextStyle(fontSize: 16, fontFamily: "New"),
          ),
        ),
        Expanded(
          child: Text(
            "\$" + cost,
            style: TextStyle(fontSize: 16, fontFamily: "New"),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}

Widget colors(List colors) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    height: 50,
    child: Row(children: [
      Expanded(
          child: Text('Colors',
              style: TextStyle(fontSize: 16, fontFamily: "New"))),
      Expanded(
        child: Container(
          height: 20,
          //width: 300,
          child: ListView.builder(
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            itemBuilder: (BuildContext context, int index) {
              var color = int.parse('0xFF' + colors[index]);
              return Container(
                height: 40,
                width: 30,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Color(color)),
              );
            },
          ),
        ),
      )
    ]),
  );
}

Widget description(String description) {
  return Container(
    //height: 100,
    //width: 300,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.blue,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Container(
      alignment: Alignment.topLeft,
      //width: totalWidth / 1.2,
      //height: totalHeight / 4.54 - 43,
      child: Text(
        description,
        textAlign: TextAlign.left,
        //maxLines: 7,
        style: TextStyle(fontFamily: "New", fontSize: 13),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    ),
  );
}

Widget rating(double Rating) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    //height: 50,
    child: Row(
      children: [
        Expanded(
          child: Text(
            'Rating',
            style: TextStyle(fontSize: 16, fontFamily: "New"),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SmoothStarRating(
                isReadOnly: true,
                rating: Rating,
                size: 20,
                starCount: 5,
              ),
              Text(
                '     ' + Rating.toString(),
                style: TextStyle(fontSize: 16, fontFamily: "New"),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget reviews(BuildContext context, String id, review bestReview) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    //height: 50,
    child: Column(
      children: [
        SizedBox(height: 7),
        Container(
          height: 70,
          width: 250,
          color: Colors.white54,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, top: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        bestReview.date!,
                        style: TextStyle(fontSize: 8, fontFamily: "New"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 15, top: 10),
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SmoothStarRating(
                            rating: 4.2,
                            size: 10,
                            starCount: 5,
                          ),
                          Text(
                            ' ${bestReview.rating}',
                            style: TextStyle(fontSize: 9, fontFamily: "New"),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 5),
                alignment: Alignment.topLeft,
                child: Text(
                  "${bestReview.name} :",
                  style: TextStyle(fontSize: 11, fontFamily: "New"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 5),
                alignment: Alignment.topLeft,
                child: Text(
                  bestReview.text!,
                  style: TextStyle(fontSize: 9, fontFamily: "New"),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

class imagesCarousel extends StatefulWidget {
  List images;
  imagesCarousel(this.images, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return imagesCarouselState();
  }
}

class imagesCarouselState extends State<imagesCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Expanded(
          child: CarouselSlider.builder(
            carouselController: _controller,
            itemCount: widget.images.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Container(
              child: Container(
                  height: 200,
                  color: Colors.white54,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    child: Image.network(widget.images[itemIndex],
                        fit: BoxFit.fitHeight),
                  )),
            ),
            options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.blue)
                        .withOpacity(_current == entry.key ? 1 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}

Widget favorite(BuildContext context, product pro) {
  return Container(
    child: IconButton(
      icon: Icon(detalisProvider.getWatch(context).icon,
          color: detalisProvider.getWatch(context).iconColor),
      iconSize: 25,
      onPressed: () {
        if (FirebaseAuth.instance.currentUser == null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return signIn();
          }));
          return;
        }
        detalisProvider.getRead(context).buttonPressed(
            context, FirebaseAuth.instance.currentUser!.email!, pro);
      },
    ),
  );
}

Widget sendRequest(BuildContext context, product pro) {
  return Container(
    height: 50,
    width: 200,
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            var selectedIndex = 0;

            /* widgetss.add(Container(
              height: 10,
              width: 10,
              color: Colors.red,
            ));
            widgetss
                .add(Container(height: 10, width: 10, color: Colors.yellow));
*/
            // widgetss.add(demo(Colors.red));
            // widgetss.add(demo(Colors.yellow));

            //Widget showedWidget = widgetss[1];
            return slAlert(selectedIndex, pro);
          },
        );
        /* Navigator.push(context, MaterialPageRoute(builder: (context) {
          return sfSelectPage(
            pro,
          );
        }));*/
      },
      child: Text(
        "Start Request",
        style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: "New"),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ))),
    ),
  );
}

class slAlert extends StatelessWidget {
  product pro;
  int selectedIndex;
  slAlert(this.selectedIndex, this.pro, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<orderProvider>(
        create: (_) {
          return orderProvider();
        },
      ),
    ], child: sfAlert(selectedIndex, pro));
    //sfAlert(selectedIndex,pro);
  }
}

class sfAlert extends StatefulWidget {
  product pro;
  int selectedIndex;
  sfAlert(this.selectedIndex, this.pro, {Key? key}) : super(key: key);

  @override
  State<sfAlert> createState() => _sfAlertState();
}

class _sfAlertState extends State<sfAlert> {
  @override
  Widget build(BuildContext context) {
    var colors = widget.pro.colors!;
    List<colorsAndQuantityList> widgetss = [];
    for (int i = 0; i < widget.pro.sizes!.length; i++) {
      widgetss.add(colorsAndQuantityList(widget.pro.sizes![i], colors));
    }
    print(widgetss.length);
    return AlertDialog(
      elevation: 0,
      title: Text("Confirm Adding"),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                //color: Colors.amber,
                height: 30,
                width: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.pro.sizes!.length,
                  itemBuilder: (BuildContext context, int index) {
                    // print("asdasd" + widgetss.length.toString());

                    return GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: widget.selectedIndex == index
                              ? Border.all(color: Colors.blue, width: 2)
                              : null,
                        ),
                        height: 40,
                        width: 40,
                        child: Text(
                          widget.pro.sizes![index],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      onTap: () {
                        widget.selectedIndex = index;

                        setState(
                          () {},
                        );
                        print(widget.selectedIndex);
                        // print(widgetss[selectedIndex]);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey,
                ),
                height: 1,
                width: 100,
              ),
              SizedBox(height: 20),
              /*selectedIndex == 0
                          ? Container(
                              height: 10,
                              width: 10,
                              color: Colors.red,
                            )
                          : Container(
                              height: 10,
                              width: 10,
                              color: Colors.yellow),*/
              // widgetss[selectedIndex],
              IndexedStack(
                index: widget.selectedIndex,
                children: widgetss,
              ),
              Text("asd")
            ],
          );
        },
      ),
      actions: [
        OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("no")),
        OutlinedButton(
            onPressed: () async {
              Map s = orderProvider.getRead(context).items;
              int totalQuantity = 0;
              s.forEach((key, value) {
                totalQuantity += int.parse(value);
              });
              // print(totalQuantity);
              purchase p = purchase(
                  p: widget.pro, quantity: totalQuantity.toString(), dtalis: s);
              purchaseProvider.getRead(context).addToPurchase(p);
              purchaseProvider
                  .getRead(context)
                  .addToTotal(int.parse(p.p!.cost!) * int.parse(p.quantity!));
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Done")));

              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text("yes")),
      ],
    );
  }
}

/*class demo extends StatefulWidget {
  Color c;
  int co = 0;
  demo(this.c, {Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 20,
        width: 20,
        color: widget.c,
        child: Text(widget.co.toString()),
      ),
      onTap: () {
        setState(() {
          widget.co++;
        });
      },
    );
  }
}*/

class slcolorsAndQuantityList extends StatelessWidget {
  var size;
  var colors;
  slcolorsAndQuantityList(this.size, this.colors, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<orderProvider>(
        create: (_) {
          return orderProvider();
        },
      ),
    ], child: colorsAndQuantityList(size, colors));
  }
}

class colorsAndQuantityList extends StatefulWidget {
  var size;
  var colors;

  colorsAndQuantityList(this.size, this.colors, {Key? key}) : super(key: key);

  @override
  State<colorsAndQuantityList> createState() => colorsAndQuantityListState();
}

class colorsAndQuantityListState extends State<colorsAndQuantityList> {
  @override
  Widget build(BuildContext context) {
    print("colorsAndQuantityListState state");
    return Container(
      //alignment: Alignment.topLeft,
      //color: Colors.amber,
      height: 200,
      width: 200,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.colors!.length,
        itemBuilder: (BuildContext context, int index) {
          // print("build sub");
          //var color = int.parse('0xFF' + pro.colors![index]);
          var color = int.parse('0xFF' + widget.colors![index]);
          // var quantitiy = 0;
          //TextEditingController textController =
          //  TextEditingController();
          //textController.text = quantitiy.toString();
          return oneColor(widget.size, widget.colors![index]);
        },
      ),
    );
  }
}

class oneColor extends StatefulWidget {
  String color;
  String size;
  TextEditingController textController = TextEditingController();
  var quantitiy = 0;
  oneColor(this.size, this.color, {Key? key}) : super(key: key);

  @override
  State<oneColor> createState() => _oneColorState();
}

class _oneColorState extends State<oneColor> {
  @override
  Widget build(BuildContext context) {
    print("one color state");
    //var color = int.parse('0xFF' + pro.colors![index]);
    var color = int.parse('0xFF' + widget.color);

    widget.textController.text = widget.quantitiy.toString();
    return Row(
      children: [
        GestureDetector(
          child: Container(
            height: 40,
            width: 30,
            decoration: BoxDecoration(
                //border:
                shape: BoxShape.circle,
                color: Color(color)),
          ),
          onTap: () {},
        ),
        Spacer(),
        Container(
            height: 30,
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.quantitiy++;
                    var key = widget.size + '0xFF' + widget.color;
                    //print(key);
                    orderProvider
                        .getRead(context)
                        .editItems(key, widget.quantitiy.toString());
                    setState(
                      () {
                        widget.textController.text =
                            widget.quantitiy.toString();
                      },
                    );
                    //print("increase quan  " + quantitiy.toString());
                  },
                  child: Icon(
                    Icons.arrow_circle_up,
                    size: 20,
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    child: TextField(
                      textAlign: TextAlign.center,
                      readOnly: true,
                      controller: widget.textController,
                    )),
                GestureDetector(
                  onTap: () {
                    //print("Quan before" + quantitiy.toString());

                    if (widget.quantitiy <= 0) {
                      return;
                    }

                    widget.quantitiy--;
                    var key = widget.size + '0xFF' + widget.color;
                    //print(key);
                    orderProvider
                        .getRead(context)
                        .editItems(key, widget.quantitiy.toString());
                    setState(() {
                      widget.textController.text = widget.quantitiy.toString();
                    });
                    // print("decrease quan  " + quantitiy.toString());
                  },
                  child: Icon(
                    Icons.arrow_circle_down,
                    size: 20,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}


/*class sfSelectPage extends StatefulWidget {
  product pro;
  sfSelectPage(this.pro, {Key? key}) : super(key: key);

  @override
  State<sfSelectPage> createState() => stateSelectPage();
}

class stateSelectPage extends State<sfSelectPage> {
  var isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            //color: Colors.amber,
            height: 30,
            width: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.pro.colors!.length,
              itemBuilder: (BuildContext context, int index) {
                print("build all");
                return GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected == index
                          ? Border.all(color: Colors.blue, width: 2)
                          : null,
                    ),
                    height: 40,
                    width: 40,
                    child: Text(
                      widget.pro.sizes![index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  onTap: () {
                    setState(
                      () {
                        isSelected = index;
                      },
                    );
                    print(isSelected);
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey,
            ),
            height: 1,
            width: 100,
          ),
          SizedBox(height: 20),
          Container(
            //alignment: Alignment.topLeft,
            //color: Colors.amber,
            height: 200,
            width: 200,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.pro.sizes!.length,
                itemBuilder: (BuildContext context, int index) {
                  return oneColor(widget.pro.colors![index]);
                }),
          ),
          Text("asd")
        ],
      ),
    );
  }
}*/