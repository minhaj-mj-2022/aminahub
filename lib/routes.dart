import 'package:aminahub/imports.dart';
import 'package:aminahub/screens/bookmarks/bookmarks.dart';
import 'package:aminahub/screens/help_center.dart';
import 'package:aminahub/screens/profile/components/my_account.dart';
import 'package:aminahub/screens/profile/components/my_ads.dart';
import 'package:aminahub/screens/profile/components/upload.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  MyAccount.routeName: (context) => MyAccount(),
  FavouritesScreen.routeName: (context) => FavouritesScreen(),
  HelpCenterScreen.routeName: (context) => HelpCenterScreen(),
  UploadForm.routeName: (context) => UploadForm(),
  MyAds.routeName: (context) => MyAds(),
};
