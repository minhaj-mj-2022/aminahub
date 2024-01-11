// import 'package:aminahub/imports.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'components/sign_up_form.dart';
//
// class SignUpScreen extends StatefulWidget {
//   static String routeName = "/sign_up";
//
//   const SignUpScreen({super.key});
//
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   bool _isLoading = false;
//
//   Future<void> _handleGoogleSignIn(BuildContext context) async {
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//
//       final UserCredential authResult =
//           await FirebaseAuth.instance.signInWithCredential(credential);
//
//       final User? user = authResult.user;
//
//       // Save the user to Firebase collection
//       await saveUserToFirebase(user);
//
//       setState(() {
//         _isLoading = false;
//       });
//
//       // Redirect to the home screen
//       Navigator.pushReplacementNamed(context, HomeScreen.routeName);
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error during Google Sign In: $e");
//       }
//
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> saveUserToFirebase(User? user) async {
//     if (user != null) {
//       // Access Firebase Firestore
//       final CollectionReference usersCollection =
//           FirebaseFirestore.instance.collection('users');
//
//       // Save user data to Firestore
//       await usersCollection.doc(user.email).set({
//         'email': user.email,
//         'displayName': user.displayName,
//         // Add other user data fields as needed
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sign Up"),
//       ),
//       body: SafeArea(
//         child: _isLoading
//             ? Center(child: CircularProgressIndicator())
//             : SizedBox(
//                 width: double.infinity,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: getProportionateScreenWidth(20)),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 16),
//                         Text("Register Account", style: headingStyle),
//                         const Text(
//                           "Complete your details or continue \nwith social media",
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(height: SizeConfig.screenHeight * 0.08),
//                         SignUpForm(),
//                         SizedBox(height: SizeConfig.screenHeight * 0.03),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () => _handleGoogleSignIn(context),
//                               child: const Text("Sign In with Google"),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: getProportionateScreenHeight(20)),
//                         Text(
//                           'By continuing your confirm that you agree \nwith our Term and Condition',
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context).textTheme.bodySmall,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }

import 'package:aminahub/imports.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/sign_up";

  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

      await _signInWithCredential(context, credential);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _handleFacebookSignIn(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final AccessToken result =
          (await FacebookAuth.instance.login()) as AccessToken;

      final AuthCredential credential =
          FacebookAuthProvider.credential(result.token);

      await _signInWithCredential(context, credential);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _signInWithCredential(
      BuildContext context, AuthCredential credential) async {
    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final User? user = authResult.user;

    // Save the user to Firebase collection
    await saveUserToFirebase(user);

    setState(() {
      _isLoading = false;
    });

    // Redirect to the home screen
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  void _handleError(dynamic e) {
    if (kDebugMode) {
      print("Error: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> saveUserToFirebase(User? user) async {
    if (user != null) {
      // Access Firebase Firestore
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Save user data to Firestore
      await usersCollection.doc(user.email).set({
        'email': user.email,
        'displayName': user.displayName,
        // Add other user data fields as needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          Text("Register Account", style: headingStyle),
                          const Text(
                            "Complete your details or continue \nwith social media",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          SignUpForm(),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () => _handleGoogleSignIn(context),
                                child: const Text("Sign In with Google"),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => _handleFacebookSignIn(context),
                                child: const Text("Sign In with Facebook"),
                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Text(
                            'By continuing your confirm that you agree \nwith our Term and Condition',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
