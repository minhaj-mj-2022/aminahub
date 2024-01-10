import 'package:aminahub/components/no_acc_text.dart';
import 'package:aminahub/imports.dart';
import 'package:aminahub/screens/sign_in/components/sign_form.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyBody extends StatefulWidget {
  MyBody({Key? key}) : super(key: key);

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = authResult.user;

      setState(() {
        _isLoading = false;
      });

      // Redirect to the home screen
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } catch (e) {
      if (kDebugMode) {
        print("Error during Google Sign In: $e");
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                const SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _handleGoogleSignIn(context),
                      child: const Text("Sign In with Google"),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                const NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
