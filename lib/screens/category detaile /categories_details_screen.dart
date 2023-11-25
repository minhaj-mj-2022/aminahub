// import 'package:flutter/material.dart';
// import '../../models/Products.dart';
// import '../home/home_screen.dart';
// import 'components/product_card.dart';

// class CategoryDetails extends StatelessWidget {
//   final String barTitle;
//   //final List <Product> productCategory;

//   const CategoryDetails(
//       {super.key,
//         required this.barTitle,
//         //this.productCategory,
//       });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           barTitle,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(context, HomeScreen.routeName);
//           },
//           child: const Icon(Icons.arrow_back),
//         ),
//       ),
//       body: ProductCardCategory(demoProducts),
//     );
//   }
// }


// import 'package:aminahub/size_config.dart';
// import 'package:flutter/material.dart';
// import '../../models/clssified_ads.dart';
// import '../home/home_screen.dart';
// import 'components/product_card.dart';

// class CategoryDetails extends StatelessWidget {
  
//   final String barTitle;
//   const CategoryDetails({
//     super.key,
//     required this.barTitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           barTitle,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(context, HomeScreen.routeName);
//           },
//           child: const Icon(Icons.arrow_back),
//         ),
//       ),
//       body: Column(
//         children: [
//           Image.asset(
//             "assets/images/aminahub.png",
//             height: getProportionateScreenHeight(30),
//           ),
//           SizedBox(height: 15,),
//           Expanded(
//             child: ProductCardCategory(demoProducts),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:aminahub/models/clssified_ads.dart';
import 'package:aminahub/screens/category%20detaile%20/components/product_card.dart';
import 'package:aminahub/screens/home/home_screen.dart';
import 'package:aminahub/size_config.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatelessWidget {
  final String barTitle;

  const CategoryDetails({
    Key? key,
    required this.barTitle,
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
          Image.asset(
            "assets/images/aminahub.png",
            height: getProportionateScreenHeight(30),
          ),
          const SizedBox(height: 15,),
          FutureBuilder<List<Product>>(
            future: ProductService().getProducts(),
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


