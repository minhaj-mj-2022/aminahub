// import 'package:aminahub/screens/home/components/body.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import '../../components/custom_btm_nav_bar.dart';
// import '../../enums.dart';
// import '../selectLocation/select_city.dart';

// class HomeScreen extends StatefulWidget {
//   static const String routeName = "/home";

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String currentCity = "Loading...";

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }

//   void _getLocation() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
//       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);

//       if (placeMarks.isNotEmpty) {
//         Placemark placeMark = placeMarks[0];
//         String? city = placeMark.locality;
//         setState(() {
//           currentCity = city ?? "failed";
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text(
//           currentCity,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: HomeBody(),
//       bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.home),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color(0xFF80D0D9),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => SelectLocation(currentCity),
//             ),
//           ).then((selectedCity) {
//             if (selectedCity != null) {
//               setState(() {
//                 currentCity = selectedCity;
//               });
//             }
//           });
//         },
//         child: const Icon(
//           Icons.location_on,
//           color: Color(0XFFFAAB37),
//           ),
//       ),
//     );
//   }
// }

import 'package:aminahub/screens/home/components/body.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../components/custom_btm_nav_bar.dart';
import '../../enums.dart';
import '../selectLocation/select_city.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentCity = "Loading...";

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placeMarks.isNotEmpty) {
        Placemark placeMark = placeMarks[0];
        String? city = placeMark.locality;
        setState(() {
          currentCity = city ?? "failed";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable the back button.
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            currentCity,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: HomeBody(),
        bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.home),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF80D0D9),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectLocation(currentCity),
              ),
            ).then((selectedCity) {
              if (selectedCity != null) {
                setState(() {
                  currentCity = selectedCity;
                });
              }
            });
          },
          child: const Icon(
            Icons.location_on,
            color: Color(0XFFFAAB37),
          ),
        ),
      ),
    );
  }
}
