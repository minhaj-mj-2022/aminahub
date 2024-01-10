import 'package:aminahub/screens/sign_in/components/body.dart';
import 'package:aminahub/size_config.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: MyBody(),
    );
  }
}
