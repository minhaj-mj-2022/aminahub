import 'package:aminahub/helper/keyboard.dart';
import '../../../imports.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  var emailAddress;
  var password;
  bool? remember = false;
  final List<String?> errors = [];
  

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


  Future<void> _signIn() async {
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
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress!,
      password: password!,
    );
    Navigator.pushNamed(context, HomeScreen.routeName);
  } catch (e) {
  // Handle any exceptions or errors that occur
  print(e);

  // Show the toast message
  Fluttertoast.showToast(
    msg: 'Wrong email or password',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
        //  Row(
          //  children: [
              // Checkbox(
              //   value: remember,
              //   activeColor: kPrimaryColor,
              //   onChanged: (value) {
              //     setState(() {
              //       remember = value;
              //     });
              //   },
              // ),
              //const Text("Remember me"),
              //const Spacer(),
              // GestureDetector(
              //   onTap: () => Navigator.pushNamed(
              //       context, ForgotPasswordScreen.routeName),
              //   child: const Text(
              //     "Forgot Password",
              //     style: TextStyle(decoration: TextDecoration.underline),
              //   ),
              // )
            //],
         // ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
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
              _signIn();
              KeyboardUtil.hideKeyboard(context);
            }
          },)
        ],
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
        return; 
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
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => emailAddress = newValue,
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
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}

