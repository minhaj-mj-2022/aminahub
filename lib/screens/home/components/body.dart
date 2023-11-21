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
            SizedBox(height: getProportionateScreenWidth(15)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(15)),
            AdsCategories(),
            SizedBox(height: getProportionateScreenWidth(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(title: "Special for you", press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => CategoryDetails(barTitle: 'Popular Products')),
                );
              }),
            ),
            const SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(title: "Popular Products", press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => CategoryDetails(barTitle: 'Popular Products')),
                );
              }),
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            ProductCarousal(demoProducts),
            SizedBox(height: getProportionateScreenWidth(15)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SectionTitle(title: "Best Deals", press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => CategoryDetails(barTitle: 'Best Deals')),
                );
              }),
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            ProductCarousal(demoProducts),
          ],
        ),
      ),
    );
  }
}
