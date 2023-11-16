import 'package:aminahub/models/Products.dart';
import 'package:aminahub/screens/home/components/product_carousal.dart';
import 'package:aminahub/screens/home/components/section_title.dart';
import 'package:aminahub/screens/home/components/special_offers.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import '../../category detaile /categories_details_screen.dart';
import 'ads_categories.dart';
import 'home_header.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  _HomeBodyState createState() => _HomeBodyState();
}
class _HomeBodyState extends State<HomeBody> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/aminahub.png',
                height: 30,
            ),
            SizedBox(height: getProportionateScreenWidth(35)),
            const HomeHeader(),
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
            const SpecialOffers(),
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
