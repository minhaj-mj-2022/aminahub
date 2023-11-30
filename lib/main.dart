// import 'package:aminahub/imports.dart';
// import 'package:aminahub/theme.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   bool isFirstLaunch = await isFirstAppLaunch();
//   runApp(MyApp(initialRoute: isFirstLaunch ? SplashScreen.routeName : HomeScreen.routeName));
// }

// class MyApp extends StatelessWidget {
//   final String initialRoute;

//   const MyApp({Key? key, required this.initialRoute}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme(context),
//       initialRoute: initialRoute,
//       routes: routes,
//     );
//   }
// }

// Future<bool> isFirstAppLaunch() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

//   if (isFirstLaunch) {
//     prefs.setBool('isFirstLaunch', false);
//   }
//   return isFirstLaunch;
//   //return true;
// }


import 'package:aminahub/imports.dart';
import 'package:aminahub/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  bool isFirstLaunch = await isFirstAppLaunch();
  User? user = FirebaseAuth.instance.currentUser;

  runApp(MyApp(
    initialRoute: user != null ? HomeScreen.routeName : isFirstLaunch ? SplashScreen.routeName : SignInScreen.routeName,
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}

Future<bool> isFirstAppLaunch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    prefs.setBool('isFirstLaunch', false);
  }
  return isFirstLaunch;
}



