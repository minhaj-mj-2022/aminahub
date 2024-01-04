import '../../../imports.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool isLoadingShown = false;

  FutureBuilder<List<Product>> _buildProductCarousal(
      String category, String sectionTitle) {
    return FutureBuilder<List<Product>>(
      future: ProductService().getAdsByCategory(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          if (!isLoadingShown) {
            isLoadingShown = true;
            return const CircularProgressIndicator();
          } else {
            return const SizedBox.shrink();
          }
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Product> products = snapshot.data ?? [];
          if (products.isEmpty) {
            return const Text('');
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(
                title: sectionTitle,
                press: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CategoryDetails(barTitle: sectionTitle),
                    ),
                  );
                },
              ),
              ProductCarousal(products),
              SizedBox(height: getProportionateScreenWidth(10)),
            ],
          );
        }
      },
    );
  }

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
            const AdsCategories(),

            SizedBox(height: getProportionateScreenWidth(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: SectionTitle(
                title: "Special for you",
                press: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const CategoryDetails(barTitle: 'Special For you'),
                    ),
                  );
                },
              ),
            ),
            const SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(20)),

            //_buildProductCarousal("Popular Products", "Popular Products"),
            //_buildProductCarousal("Best Deals", "Best Deals"),
            _buildProductCarousal("IT Training", "IT Training"),
            _buildProductCarousal("Rentals", "Rentals"),
            _buildProductCarousal("Services", "Services"),
            _buildProductCarousal("Property", "Property"),
            _buildProductCarousal("Events", "Events"),
            _buildProductCarousal("buySell", "Buy/Sell"),
            _buildProductCarousal("travel", "Travel"),
            _buildProductCarousal("lawyer", "Lawyer"),
            _buildProductCarousal("roommates", "Roommates"),
            _buildProductCarousal("homeservices", "Home Services"),
          ],
        ),
      ),
    );
  }
}
