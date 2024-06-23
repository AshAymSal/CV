import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
