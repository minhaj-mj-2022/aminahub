import 'package:aminahub/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../models/Products.dart';
import '../../category detaile /detailed_screen.dart';

class ProductCarousal extends StatelessWidget {
  final List<Product> products;

  ProductCarousal(this.products);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: getProportionateScreenHeight(250),
        width: SizeConfig.screenWidth,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          //itemCount: products.length,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(products[index]),
                  ),
                );
              },
              child: buildProductCard(products[index]),
            );
          },
        ),
      ),
    );
  }

  Widget buildProductCard(Product product) {
    return Container(
      width: 160,// Adjust the width as needed
      margin: EdgeInsets.only(right: 15), // Adjust the margin as needed
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFE0F2F1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 0,
            blurRadius: 12,
            offset: Offset(5, 12),
            blurStyle: BlurStyle.outer
          ),
        ],
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Image.asset(product.images[0]),
          ),
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price}",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SvgPicture.asset(
                "assets/icons/Heart Icon_2.svg",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
