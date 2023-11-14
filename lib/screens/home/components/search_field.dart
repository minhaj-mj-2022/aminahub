// import 'package:flutter/material.dart';
// import '../../../constants.dart';
// import '../../../size_config.dart';
//
// class SearchField extends StatelessWidget {
//   const SearchField({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: SizeConfig.screenWidth * 0.9,
//       decoration: BoxDecoration(
//         color: kSecondaryColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: TextField(
//         onChanged: (value) => print(value),
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(
//                 horizontal: getProportionateScreenWidth(20),
//                 vertical: getProportionateScreenWidth(9)),
//             border: InputBorder.none,
//             focusedBorder: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             hintText: "Search services",
//             prefixIcon: Icon(Icons.search)),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../category detaile /categories_details_screen.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final List<String> items = [
    'Education and Training',
    'Home Services',
    'Business Services',
    'Properties - Buy,Rent, Roommate',
    'IT Training',
    'Health and Wellness',
    'Events'
  ];
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.9,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return items.where((String item) =>
              item.toLowerCase().contains(textEditingValue.text.toLowerCase()));
        },
        onSelected: (String item) {
          navigateToNewScreen(item);
        },
        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9),
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Search services",
              prefixIcon: Icon(Icons.search),
            ),
          );
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: getProportionateScreenHeight(300),
                  maxWidth: SizeConfig.screenWidth * 0.9,
                ),
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(option),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToNewScreen(String item) {
    // Use Navigator to navigate to the new screen
    // Replace 'NewScreen' with the name of your new screen
    Navigator.of(context).push(
      MaterialPageRoute(
        //builder: (context) => NewScreen(item), // Pass the selected item to the new screen
        builder: (context) => CategoryDetails(barTitle: item,), // Pass the selected item to the new screen
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  final String selectedItem;

  NewScreen(this.selectedItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Screen'),
      ),
      body: Center(
        child: Text('You selected: $selectedItem'),
      ),
    );
  }
}
