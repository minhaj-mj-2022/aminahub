import 'package:flutter/material.dart';
import '../../models/Products.dart';
import '../home/home_screen.dart';
import 'components/product_card.dart';

class CategoryDetails extends StatelessWidget {
  final String barTitle;
  //final List <Product> productCategory;

  const CategoryDetails(
      {Key? key,
        required this.barTitle,
        //this.productCategory,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          barTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        child: ProductCardCategory(demoProducts),
      ),
    );
  }
}
