import '../../imports.dart';

class CategoryIcons extends StatelessWidget {
  final String? barTitle;
  var a;

  CategoryIcons({
    super.key,
    required this.barTitle,
    this.a
  });

  String aa(){
    a = barTitle;
    print(a);
    print("event");
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          barTitle!,
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
          SizedBox(height: getProportionateScreenWidth(10)),
          Image.asset(
            "assets/images/aminahub_backup.png",
            height: getProportionateScreenHeight(20),
          ),
          SizedBox(height: getProportionateScreenHeight(10),),
          FutureBuilder<List<Product>>(
            //String 
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


