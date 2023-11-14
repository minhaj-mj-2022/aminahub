import 'package:aminahub/models/Products.dart';
import 'package:aminahub/screens/home/components/product_carousal.dart';
import 'package:aminahub/screens/home/components/section_title.dart';
import 'package:aminahub/screens/home/components/special_offers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import '../../category detaile /categories_details_screen.dart';
import 'ads_categories.dart';
import 'best_deals.dart';
import 'home_header.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}
class _HomeBodyState extends State<HomeBody> {

  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(15)),
            AdsCategories(),
            SizedBox(height: getProportionateScreenWidth(20)),
            Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(20),
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(20),
              ),
              child: SectionTitle(title: "Special for you", press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => CategoryDetails(barTitle: 'Popular Products')),
                );
              }),
            ),
            SpecialOffers(),
            Padding(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(20),
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(20),
              ),
              child: SectionTitle(title: "Popular Products", press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => CategoryDetails(barTitle: 'Popular Products')),
                );
              }),
            ),
            SizedBox(height: getProportionateScreenWidth(20)),
            ProductCarousal(demoProducts),
            Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(20),
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(20),
              ),
              child: SectionTitle(title: "Best Deals", press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => CategoryDetails(barTitle: 'Popular Products')),
                );
              }),
            ),
            ProductCarousal(demoProducts),
          ],
        ),
      ),
    );
  }
}
