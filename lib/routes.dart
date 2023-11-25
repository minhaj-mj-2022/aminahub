import 'package:aminahub/screens/complete_profile/complete_profile_screen.dart';
import 'package:aminahub/screens/forgot_password/forgot_password_screen.dart';
import 'package:aminahub/screens/home/home_screen.dart';
import 'package:aminahub/screens/login_success/login_success_screen.dart';
import 'package:aminahub/screens/otp/otp_screen.dart';
import 'package:aminahub/screens/profile/profile_screen.dart';
import 'package:aminahub/screens/sign_in/sign_in_screen.dart';
import 'package:aminahub/screens/sign_up/sign_up_screen.dart';
import 'package:aminahub/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};
