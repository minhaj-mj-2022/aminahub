// import '../imports.dart';

// class HelpCenterScreen extends StatelessWidget {
//   final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
//   static String routeName = "/HelpCenterScreen";

//   HelpCenterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Help Center'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Contact Information:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const Text('Email: support@example.com'),
//             const Text('Phone: +1 (123) 456-7890'),
//             const SizedBox(height: 20),
//             const Text(
//               'Feedback Form:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             FormBuilder(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   FormBuilderTextField(
//                     name: 'feedback',
//                     decoration: const InputDecoration(labelText: 'Your Feedback'),
//                   ),
//                   const SizedBox(height: 20),
//                   DefaultButton(
//                         text: "Submit Feedback",
//                         press: () {

//                         },
//                       ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 40),
//             Center(
//               child: InkWell(
//                 onTap: () => _launchPrivacyPolicyURL(),
//                 child: const Text(
//                   'Privacy & Policy',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _launchPrivacyPolicyURL() async {
//     const privacyPolicyURL = 'https://example.com/privacy-policy';
//     if (await canLaunch(privacyPolicyURL)) {
//       await launch(privacyPolicyURL);
//     } else {
//       throw 'Could not launch $privacyPolicyURL';
//     }
//   }
// }

import 'package:aminahub/components/default_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  static String routeName = "/HelpCenterScreen";

  HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('Email: support@example.com'),
            const Text('Phone: +1 (123) 456-7890'),
            const SizedBox(height: 20),
            const Text(
              'Feedback Form:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'feedback',
                    decoration: const InputDecoration(labelText: 'Your Feedback'),
                  ),
                  const SizedBox(height: 20),
                  DefaultButton(
                    text: "Submit Feedback",
                    press: () {
                      _submitFeedback(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: InkWell(
                onTap: () => _launchPrivacyPolicyURL(),
                child: const Text(
                  'Privacy & Policy',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchPrivacyPolicyURL() async {
    const privacyPolicyURL = 'https://example.com/privacy-policy';
    if (await canLaunch(privacyPolicyURL)) {
      await launch(privacyPolicyURL);
    } else {
      throw 'Could not launch $privacyPolicyURL';
    }
  }

  void _submitFeedback(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;
      final feedbackText = _formKey.currentState!.fields['feedback']!.value;
        String? currentUserEmail = FirebaseAuth.instance.currentUser!.email;

      await FirebaseFirestore.instance.collection('feedback').doc(currentUserEmail).set({
        'feedback': feedbackText,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feedback submitted successfully!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please log in before submitting feedback.'),
        ),
      );
    }
  }
}
