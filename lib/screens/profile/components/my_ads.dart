import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyAds extends StatefulWidget {
  static const String routeName = '/MyAds';

  const MyAds({Key? key}) : super(key: key);

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Ads'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ads')
            .where('op', isEqualTo: 'minhaj1@gmail.com') // Filter ads by user
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Display the ads in a ListView
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var ad =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              // Extract necessary information from the ad
              String imageUrl = ad['images'][0];
              String title = ad['title'];
              String price = ad['price'] ?? 'NA';

              // Display the information in a ListTile with Edit and Delete buttons
              return Column(
                children: [
                  ListTile(
                    title: Text(title),
                    subtitle: Text(
                      price,
                      style: const TextStyle(color: Colors.green),
                    ),
                    leading: Container(
                      width: 100, // Set the desired width
                      height: 100, // Set the desired height
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit
                            .cover, // Adjust the BoxFit property as needed
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Navigate to the EditAdPage, passing ad data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAdPage(ad: ad),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit, color: Colors.blue),
                        ),
                        SizedBox(width: 8), // Add some space between buttons
                        IconButton(
                          onPressed: () {
                            // Call a function to delete the ad
                            _deleteAd(snapshot.data!.docs[index].id);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Divider(), // Add a divider line between ListTiles
                ],
              );
            },
          );
        },
      ),
    );
  }

  // Function to delete the ad from Firestore
  Future<void> _deleteAd(String adId) async {
    try {
      await FirebaseFirestore.instance.collection('ads').doc(adId).delete();

      // Show a toast message
      Fluttertoast.showToast(
        msg: 'Ad deleted successfully',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      // Handle errors here
      print('Error deleting ad: $e');

      // Show an error toast message
      Fluttertoast.showToast(
        msg: 'Error deleting ad',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}

// Add a new stateful widget for the EditAdPage
class EditAdPage extends StatefulWidget {
  final Map<String, dynamic> ad;

  const EditAdPage({Key? key, required this.ad}) : super(key: key);

  @override
  State<EditAdPage> createState() => _EditAdPageState();
}

class _EditAdPageState extends State<EditAdPage> {
  // You can implement the editing functionality here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Ad'),
      ),
      body: Center(
        child: Text('Edit your ad here'),
      ),
    );
  }
}
