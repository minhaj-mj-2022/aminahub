import 'package:aminahub/size_config.dart';

import '../../../imports.dart';

class AdsCategories extends StatelessWidget {
  const AdsCategories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/itTraining.svg", "text": "ItTaining"},
      {"icon": "assets/icons/rent.svg", "text": "rent"},
      {"icon": "assets/icons/services.svg", "text": "services"},
      {"icon": "assets/icons/property.svg", "text": "property"},
      {"icon": "assets/icons/event.svg", "text": "event"},
      {"icon": "assets/icons/buySell.svg", "text": "buySell"},
      {"icon": "assets/icons/homeServices.svg", "text": "homeservices"},
      {"icon": "assets/icons/lawyer.svg", "text": "lawyer"},
      {"icon": "assets/icons/roommates.svg", "text": "roommates"},
      {"icon": "assets/icons/travel.svg", "text": "travel"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust the padding as needed
          child: SectionTitle(title: "Ads Category", press: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (BuildContext context) => CategoryDetails(barTitle: 'Popular Products')),
                // );
              }),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
    super.key,
    required this.icon,
    required this.text,
    required this.press,
  });

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
                //color: Color(0xFF84D0D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            const SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}

