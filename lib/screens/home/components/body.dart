import 'package:aminahub/size_config.dart';
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
              child: SectionTitle(
                  title: "Special for you",
                  press: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CategoryDetails(barTitle: 'Special For you')),
                    );
                  }),
            ),
            const SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(
                  title: "Popular Products",
                  press: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CategoryDetails(barTitle: 'Popular Products')),
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
                    return const Text('Something Went Wrong');
                  }
                  return ProductCarousal(products);
                }
              },
            ),
            SizedBox(height: getProportionateScreenWidth(15)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(
                  title: "Best Deals",
                  press: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CategoryDetails(barTitle: 'Best Deals')),
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
                    return const Text('Something Went Wrong');
                  }
                  return ProductCarousal(products);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(
                  title: "IT Training",
                  press: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CategoryDetails(barTitle: 'IT Training')),
                    );
                  }),
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            FutureBuilder<List<Product>>(
              future: ProductService().getAdsByCategory("IT Training"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Product> products = snapshot.data ?? [];
                  if (products.isEmpty) {
                    return const Text('Something Went Wrong');
                  }
                  return ProductCarousal(products);
                }
              },
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(
                  title: "Rentals",
                  press: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CategoryDetails(barTitle: 'Rentals')),
                    );
                  }),
            ),
            FutureBuilder<List<Product>>(
              future: ProductService().getAdsByCategory("Rentals"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Product> products = snapshot.data ?? [];
                  if (products.isEmpty) {
                    return const Text('Something Went Wrong');
                  }
                  return ProductCarousal(products);
                }
              },
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(
                  title: "Services",
                  press: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CategoryDetails(barTitle: 'Services')),
                    );
                  }),
            ),
            FutureBuilder<List<Product>>(
              future: ProductService().getAdsByCategory("Services"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Product> products = snapshot.data ?? [];
                  if (products.isEmpty) {
                    return const Text('Something Went Wrong');
                  }
                  return ProductCarousal(products);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(
                  title: "Property",
                  press: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CategoryDetails(barTitle: 'Property')),
                    );
                  }),
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            FutureBuilder<List<Product>>(
              future: ProductService().getAdsByCategory("Property"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Product> products = snapshot.data ?? [];
                  if (products.isEmpty) {
                    return const Text('Something Went Wrong');
                  }
                  return ProductCarousal(products);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(
                  title: "Events",
                  press: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CategoryDetails(barTitle: 'Events')),
                    );
                  }),
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            FutureBuilder<List<Product>>(
              future: ProductService().getAdsByCategory("Events"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Product> products = snapshot.data ?? [];
                  if (products.isEmpty) {
                    return const Text('Something Went Wrong');
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
