// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../size_config.dart';
//
// class AdsCategories extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> categories = [
//       {"icon": "assets/icons/Flash Icon.svg", "text": "Phone"},
//       {"icon": "assets/icons/Bill Icon.svg", "text": "Electronics"},
//       {"icon": "assets/icons/Flash Icon.svg", "text": "Tutor"},
//       {"icon": "assets/icons/Bill Icon.svg", "text": "More"},
//       {"icon": "assets/icons/Flash Icon.svg", "text": "More"},
//       {"icon": "assets/icons/Bill Icon.svg", "text": "More"},
//       {"icon": "assets/icons/Flash Icon.svg", "text": "More"},
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20), // Adjust the padding as needed
//           child: Text(
//             "Ads Categories",
//             style: TextStyle(
//               fontSize: getProportionateScreenWidth(18),
//               color: Colors.black,
//             ),
//           ),
//         ),
//         SizedBox(height: 15),
//         SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: List.generate(
//               categories.length,
//                   (index) => CategoryCard(
//                 icon: categories[index]["icon"],
//                 text: categories[index]["text"],
//                 press: () {},
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class CategoryCard extends StatelessWidget {
//   const CategoryCard({
//     Key? key,
//     required this.icon,
//     required this.text,
//     required this.press,
//   }) : super(key: key);
//
//   final String? icon, text;
//   final GestureTapCallback press;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(getProportionateScreenWidth(5)),
//               height: getProportionateScreenWidth(50),
//               width: getProportionateScreenWidth(50),
//               decoration: BoxDecoration(
//                 color: Color(0xFFFFECDF),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: SvgPicture.asset(icon!),
//             ),
//             SizedBox(height: 5),
//             Text(text!, textAlign: TextAlign.center)
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../size_config.dart';
import '../../category detaile /categories_details_screen.dart';

class AdsCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Phone"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "Electronics"},
      {"icon": "assets/icons/Flash Icon.svg", "text": "Tutor"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "More"},
      {"icon": "assets/icons/Flash Icon.svg", "text": "More"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "More"},
      {"icon": "assets/icons/Flash Icon.svg", "text": "More"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), // Adjust the padding as needed
          child: Text(
            "Ads Categories",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 15),
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              categories.length,
                  (index) => CategoryCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoryDetails(barTitle: categories[index]["text"]),
                  ));
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(5)),
              height: getProportionateScreenWidth(50),
              width: getProportionateScreenWidth(50),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}

