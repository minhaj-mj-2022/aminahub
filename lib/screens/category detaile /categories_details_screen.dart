import 'package:flutter/material.dart';
import '../../models/Products.dart';
import '../home/home_screen.dart';
import 'components/product_card.dart';

class CategoryDetails extends StatelessWidget {
  final String barTitle;
  //final List <Product> productCategory;

  CategoryDetails(
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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        child: ProductCardCategory(demoProducts),
      ),
    );
  }
}
