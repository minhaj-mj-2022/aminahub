import 'package:aminahub/size_config.dart';

import '../../imports.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentCity = "Loading...";

  @override
  void didChangeDependencies() {
    //size config issue solved
    super.didChangeDependencies();
    SizeConfig().init(context);
    _getLocation();
  }

  void _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placeMarks.isNotEmpty) {
        Placemark placeMark = placeMarks[0];
        String? state = placeMark.administrativeArea;
        setState(() {
          currentCity = state ?? "failed";
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
        bottomNavigationBar:
            const CustomBottomNavBar(selectedMenu: MenuState.home),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xfff5e3cc4),
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
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
