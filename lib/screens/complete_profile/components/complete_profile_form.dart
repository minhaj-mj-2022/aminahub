// import 'package:flutter/material.dart';
// import '../../../components/custom_surfix_icon.dart';
// import '../../../components/default_btn.dart';
// import '../../../constants.dart';
// import '../../../size_config.dart';
// import '../../otp/otp_screen.dart';

// class CompleteProfileForm extends StatefulWidget {
//   const CompleteProfileForm({super.key});

//   @override
//   _CompleteProfileFormState createState() => _CompleteProfileFormState();
// }

// class _CompleteProfileFormState extends State<CompleteProfileForm> {
//   final _formKey = GlobalKey<FormState>();
//   final List<String?> errors = [];
//   String? firstName;
//   String? lastName;
//   String? phoneNumber;
//   String? address;

//   void addError({String? error}) {
//     if (!errors.contains(error)) {
//       setState(() {
//         errors.add(error);
//       });
//     }
//   }

//   void removeError({String? error}) {
//     if (errors.contains(error)) {
//       setState(() {
//         errors.remove(error);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           buildFirstNameFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildLastNameFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           // buildPhoneNumberFormField(),
//           // SizedBox(height: getProportionateScreenHeight(30)),
//           // buildAddressFormField(),
//           // FormError(errors: errors),
//           // SizedBox(height: getProportionateScreenHeight(40)),
//           DefaultButton(
//             text: "continue",
//             press: () {
//               if (_formKey.currentState!.validate()) {
//                 Navigator.pushNamed(context, OtpScreen.routeName);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // TextFormField buildAddressFormField() {
//   //   return TextFormField(
//   //     onSaved: (newValue) => address = newValue,
//   //     onChanged: (value) {
//   //       if (value.isNotEmpty) {
//   //         removeError(error: kAddressNullError);
//   //       }
//   //       return;
//   //     },
//   //     validator: (value) {
//   //       if (value!.isEmpty) {
//   //         addError(error: kAddressNullError);
//   //         return "";
//   //       }
//   //       return null;
//   //     },
//   //     decoration: const InputDecoration(
//   //       labelText: "Address",
//   //       hintText: "Enter your phone address",
//   //       floatingLabelBehavior: FloatingLabelBehavior.always,
//   //       suffixIcon:
//   //       CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
//   //     ),
//   //   );
//   // }

//   // TextFormField buildPhoneNumberFormField() {
//   //   return TextFormField(
//   //     keyboardType: TextInputType.phone,
//   //     onSaved: (newValue) => phoneNumber = newValue,
//   //     onChanged: (value) {
//   //       if (value.isNotEmpty) {
//   //         removeError(error: kPhoneNumberNullError);
//   //       }
//   //       return;
//   //     },
//   //     validator: (value) {
//   //       if (value!.isEmpty) {
//   //         addError(error: kPhoneNumberNullError);
//   //         return "";
//   //       }
//   //       return null;
//   //     },
//   //     decoration: const InputDecoration(
//   //       labelText: "Phone Number",
//   //       hintText: "Enter your phone number",
//   //       floatingLabelBehavior: FloatingLabelBehavior.always,
//   //       suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
//   //     ),
//   //   );
//   // }

//   TextFormField buildLastNameFormField() {
//     return TextFormField(
//       onSaved: (newValue) => lastName = newValue,
//       decoration: const InputDecoration(
//         labelText: "Last Name",
//         hintText: "Enter your last name",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//       ),
//     );
//   }

//   TextFormField buildFirstNameFormField() {
//     return TextFormField(
//       onSaved: (newValue) => firstName = newValue,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kNamelNullError);
//         }
//         return;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kNamelNullError);
//           return "";
//         }
//         return null;
//       },
//       decoration: const InputDecoration(
//         labelText: "First Name",
//         hintText: "Enter your first name",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/default_btn.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../otp/otp_screen.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;

  final CollectionReference users = FirebaseFirestore.instance.collection('users');

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                storeUserDataInFirestore();
                Navigator.pushNamed(context, OtpScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: const InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  void storeUserDataInFirestore() {
    // Add user data to Firestore
    users.add({
      'firstName': firstName,
      'lastName': lastName,
    }).then((value) {
      print("User data added to Firestore with ID: ${value.id}");
    }).catchError((error) {
      print("Failed to add user data to Firestore: $error");
    });
  }
}

