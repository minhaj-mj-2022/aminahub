import 'package:aminahub/screens/help_center.dart';
import 'package:aminahub/screens/profile/components/my_account.dart';
import 'package:aminahub/screens/profile/components/profile_menu.dart';
import 'package:aminahub/screens/profile/components/upload.dart';
import 'package:aminahub/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, SignInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          //const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {Navigator.pushNamed(context, MyAccount.routeName)},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Upload Ads",
            icon: "assets/icons/upload.svg",
            press: () => {Navigator.pushNamed(context, UploadForm.routeName)},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () =>
                {Navigator.pushNamed(context, HelpCenterScreen.routeName)},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              _signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
