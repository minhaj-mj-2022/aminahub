import '../../../imports.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.press,
  });

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff5e3cc4), // Set your desired background color here
      padding: EdgeInsets.all(5), // Adjust padding as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "     " + title,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: press,
            child: const Text(
              "See More     ",
              style: TextStyle(color: Color(0xFFFAAB37)),
            ),
          ),
        ],
      ),
    );
  }
}
