import 'package:aminahub/models/Products.dart';
import 'package:aminahub/size_config.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen(this.product, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      body: SingleChildScrollView(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/aminahub.png',
                height: 30,
            ),
            SizedBox(height: getProportionateScreenWidth(15)),
            CarouselSlider(
              items: widget.product.images.map((image) {
                return Image.asset(image);
              }).toList(),
              options: CarouselOptions(
                height: getProportionateScreenHeight(300),
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 1 / 1,
                enableInfiniteScroll: false,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeFactor: 0.1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            DotsIndicator(
              dotsCount: widget.product.images.length,
              position: _currentImageIndex,
              decorator: DotsDecorator(
                activeColor: Colors.blue,
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(height: 20), // Add some spacing
            Container(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(25), right: 30, bottom: getProportionateScreenWidth(25)),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10),),
                  Text(
                    "\$${widget.product.price}",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5),),
                  const Divider(
                    thickness: 5,
                  ),
                  SizedBox(height: getProportionateScreenHeight(10),),
                  const Text(
                    "Descriptions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ReadMoreText(
                    widget.product.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16
                    ),
                    trimLines: 5,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5),),
                  const Divider(
                    thickness: 5,
                  ),
                  const Text(
                    "Contact Info.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.product.contactInfo,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}