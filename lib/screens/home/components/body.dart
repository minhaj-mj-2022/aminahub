import '../../../imports.dart';

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
                height: getProportionateScreenHeight(60),
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
            //ProductCarousal(demoProducts),
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
            FutureBuilder<List<Product>>(
            future: ProductService().getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();  
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Product> products = snapshot.data ?? [];
                if (products.isEmpty) {
                  return const Text('No products available.');
                }
                return ProductCarousal(products);
              }
            },
          ),
          ],
        ),
      ),
    );
  }
}
