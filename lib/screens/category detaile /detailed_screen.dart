import 'package:aminahub/size_config.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:readmore/readmore.dart';
import '../../models/Products.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              items: product.images.map((image) {
                return Image.asset(image);
              }).toList(),
              options: CarouselOptions(
                height: getProportionateScreenHeight(300),
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 1/1,
                enableInfiniteScroll: false,
                autoPlayInterval: Duration(seconds: 3),
                enlargeFactor: 0.1,
              ),
            ),
            SizedBox(height: 20), // Add some spacing
            Container(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(25), right: 30, bottom: getProportionateScreenWidth(25)),
              child: Column(
                children: <Widget>[
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10),),
                  Text(
                    "\$${product.price}",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5),),
                  Divider(
                    thickness: 5,
                  ),
                  SizedBox(height: getProportionateScreenHeight(10),),
                  Text(
                    "Descriptions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ReadMoreText(
                    product.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16
                    ),
                    trimLines: 5,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5),),
                  Divider(
                    thickness: 5,
                  ),
                  Text(
                    "Contact Info.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    product.contactInfo,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
