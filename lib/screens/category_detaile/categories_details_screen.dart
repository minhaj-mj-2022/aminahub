import '../../imports.dart';
// ... (import statements)

class CategoryDetails extends StatelessWidget {
  final String barTitle;

  const CategoryDetails({
    super.key,
    required this.barTitle,
  });

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
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/images/aminahub_backup.png",
              height: getProportionateScreenHeight(20),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          FutureBuilder<List<Product>>(
            future: ProductService().getAdsByCategory(barTitle),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Product> products = snapshot.data ?? [];
                return Expanded(
                  child: ProductCardCategory(products),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
