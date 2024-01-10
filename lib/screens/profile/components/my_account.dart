import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  static const String routeName = "/MyAccount";

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late String email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email!;
  }

  Future<String?> getUserName() async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(email).get();

      if (userSnapshot.exists) {
        return userSnapshot.get('name');
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user name: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: getUserName(),
          builder: (context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAccountDetail("Email Address", email),
                  _buildAccountDetail("Name", snapshot.data),
                ],
              );
            } else {
              return const Center(
                child: Text("User not found"),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildAccountDetail(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value!,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
