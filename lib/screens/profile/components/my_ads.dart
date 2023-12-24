import 'package:aminahub/imports.dart';

class MyAds extends StatefulWidget {
  static const String routeName = '/MyAds';
  const MyAds({super.key});

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  String? originalPoster = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ads'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ads')
            .where('op', isEqualTo: originalPoster) // Filter ads by user
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

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var ad =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              String imageUrl = ad['images'][0] ?? 'NA';
              String title = ad['title'] ?? 'NA';
              String price = ad['price'] ?? 'NA';

              return Column(
                children: [
                  ListTile(
                    title: Text(title),
                    subtitle: Text(
                      price,
                      style: const TextStyle(color: Colors.green),
                    ),
                    leading: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAdPage(
                                  ad: ad,
                                  adId: snapshot.data!.docs[index].id,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        // // const SizedBox(width: 8),
                        // IconButton(
                        //   onPressed: () {
                        //     _deleteAd(snapshot.data!.docs[index].id);
                        //   },
                        //   icon: const Icon(Icons.delete, color: Colors.red),
                        // ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _deleteAd(String adId) async {
    try {
      await FirebaseFirestore.instance.collection('ads').doc(adId).delete();

      Fluttertoast.showToast(
        msg: 'Ad deleted successfully',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting ad: $e');
      }

      Fluttertoast.showToast(
        msg: 'Error deleting ad',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}

class EditAdPage extends StatefulWidget {
  final Map<String, dynamic> ad;
  final String adId;

  const EditAdPage({Key? key, required this.ad, required this.adId})
      : super(key: key);

  @override
  State<EditAdPage> createState() => _EditAdPageState();
}

class _EditAdPageState extends State<EditAdPage> {
  TextEditingController contactController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationStateController = TextEditingController();
  TextEditingController opController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  String selectedCategory = '';
  final List<String> categories = [
    'Property',
    'Events',
    'IT Training',
    'Rentals',
    'Services',
    'travel',
    'buySell',
    'homeservices',
    'lawyer',
    'roommates'
  ];

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing ad data
    contactController.text = widget.ad['contact'];
    descriptionController.text = widget.ad['description'];
    locationStateController.text = widget.ad['location_state'];
    priceController.text = widget.ad['price'];
    titleController.text = widget.ad['title'];

    // Set the initial value for the dropdown
    selectedCategory = categories.contains(widget.ad['category'])
        ? widget.ad['category']
        : categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit your Ad'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: contactController,
                decoration: const InputDecoration(labelText: 'Contact'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: locationStateController,
                decoration: const InputDecoration(labelText: 'Location State'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.ad['images'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.network(
                            widget.ad['images'][index],
                            fit: BoxFit.fitWidth,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
              const SizedBox(height: 16),
              DefaultButton(
                text: "Save Changes",
                press: () {
                  _updateAd();
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: () {
                  _showDeleteConfirmationDialog();
                },
                child: Text("Delete this Ad"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Ad"),
          content: Text("Are you sure you want to delete this ad?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAd();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAd() async {
    try {
      await FirebaseFirestore.instance
          .collection('ads')
          .doc(widget.adId)
          .delete();

      Fluttertoast.showToast(
        msg: 'Ad deleted successfully',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      Navigator.pop(context);
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting ad: $e');
      }

      Fluttertoast.showToast(
        msg: 'Error deleting ad',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      Navigator.pop(context);
    }
  }

  Future<void> _updateAd() async {
    try {
      await FirebaseFirestore.instance
          .collection('ads')
          .doc(widget.adId)
          .update({
        'category': selectedCategory,
        'contact': contactController.text,
        'description': descriptionController.text,
        'location_state': locationStateController.text,
        'price': priceController.text,
        'title': titleController.text,
      });

      Fluttertoast.showToast(
        msg: 'Ad updated successfully',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error updating ad: $e');
      }

      Fluttertoast.showToast(
        msg: 'Error updating ad',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      Navigator.pop(context);
    }
  }
}
