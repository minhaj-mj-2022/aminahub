import 'package:aminahub/screens/splash_screen/screen_body.dart';
import 'package:aminahub/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ScreenBody(),
    );
  }
}
