import 'package:aminahub/helper/keyboard.dart';

import '../../../imports.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  bool remember = false;
  final List<String?> errors = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

    void showLoadingDialog() {
  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text("Loading..."),
          ],
        ),
      );
    },
  );
}

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

Future<void> _register() async {
  try {
        FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
      globalEmail = user?.email;
      // if (user == null) {
      //   print('User is currently signed out!');
      // } else {
      //   print('User is signed in!');
      // }
    });
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  
    // Add user data to Firestore
    await FirebaseFirestore.instance.collection('users').doc(email!).set({
      'email': email!,
      'name': name!, // Replace 'YourUserName' with the actual user name
    });

    Navigator.pushNamed(context, HomeScreen.routeName);
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(
      msg: 'Something went wrong, Try again',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } catch (e) {
    print(e);
  }
}


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
          text: "Continue",
          press: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // Show CircularProgressIndicator
              showLoadingDialog();
              
              // Delay execution for 3 seconds
              await Future.delayed(Duration(seconds: 3));

              // Hide CircularProgressIndicator
              Navigator.of(context, rootNavigator: true).pop();

              KeyboardUtil.hideKeyboard(context);
              _register(); 
              KeyboardUtil.hideKeyboard(context);
            }
          },)
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirmPassword) {
          removeError(error: kMatchPassError);
        }
        confirmPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

    TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newValue) => name = newValue,
      decoration: const InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}


