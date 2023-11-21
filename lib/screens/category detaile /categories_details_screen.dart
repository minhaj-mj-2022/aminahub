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


import 'package:aminahub/size_config.dart';
import 'package:flutter/material.dart';
import '../../models/Products.dart';
import '../home/home_screen.dart';
import 'components/product_card.dart';

class CategoryDetails extends StatelessWidget {
  final String barTitle;
  //final List <Product> productCategory;

  const CategoryDetails({
    super.key,
    required this.barTitle,
    //this.productCategory,
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
          Image.asset(
            "assets/images/aminahub.png",
            height: getProportionateScreenHeight(30),
          ),
          SizedBox(height: 15,),
          Expanded(
            child: ProductCardCategory(demoProducts),
          ),
        ],
      ),
    );
  }
}

