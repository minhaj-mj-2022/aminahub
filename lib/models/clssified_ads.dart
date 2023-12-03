import 'dart:math';

import 'package:aminahub/imports.dart';

class Product {
  final String id, title, location_state, description, contactInfo, price;
  final List<String> images;

  Product({
    required this.id,
    required this.images,
    required this.title,
    required this.location_state,
    required this.price,
    required this.description,
    required this.contactInfo,
  });
}

class ProductService {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('ads');

  // Get All ads
  Future<List<Product>> getProducts() async {
    QuerySnapshot<Object?> querySnapshot = await productsCollection.get();

    List<Product> products = [];

    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;

      //List<String> images = List<String>.from(data['images']);
      List<String> images = List<String>.from(data['images']?.toList() ??
          [
            "https://firebasestorage.googleapis.com/v0/b/aminahub-18c2f.appspot.com/o/constant%2F%E2%80%94Pngtree%E2%80%94404%20error%20page_2596650.png?alt=media&token=9500fc72-5538-4e5a-abd2-6ff69cb20eee"
          ]);

      Product product = Product(
        id: data['ads_id'] ?? 0,
        title: data['title'] ?? "No value",
        description: data['description'] ?? "No value",
        contactInfo: data['contact'] ?? "No value",
        images: images,
        price: data['price'] ?? "No value",
        location_state: data['location_state'] ?? "No Value",
      );
      products.add(product);
    }
    products.shuffle(Random());
    return products;
  }

  //Get Ads By Category
  Future<List<Product>> getAdsByCategory(String? _category) async {
    QuerySnapshot<Object?> querySnapshot = await productsCollection.get();

    List<Product> products = [];

    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;

      if (data['category'] == _category) {
        List<String> images = List<String>.from(data['images']);

        Product product = Product(
          id: data['ads_id'] ?? "No Value",
          title: data['title'] ?? "No value",
          description: data['description'] ?? "No value",
          contactInfo: data['contact'] ?? "No value",
          images: images,
          price: data['price'] ?? "No value",
          location_state: data['location_state'] ?? "No Value",
        );
        products.add(product);
      }
    }
    return products;
  }

  Future<List<Product>> getBookmarks() async {
    String? currentUserEmail = FirebaseAuth.instance.currentUser!.email;

    QuerySnapshot<Object?> querySnapshot = await FirebaseFirestore.instance
        .collection("Bookmarks")
        .doc(currentUserEmail)
        .collection("items")
        .get();

    List<Product> products = [];

    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;

      List<String> images = List<String>.from(data['images']);

      Product product = Product(
        id: data['ads_id'] ?? "No Value",
        title: data['title'] ?? "No value",
        description: data['description'] ?? "No value",
        contactInfo: data['contactInfo'] ?? "No value",
        images: images,
        price: data['price'] ?? "No value",
        location_state: data['location_state'] ?? "No Value",
      );
      products.add(product);
    }
    return products;
  }
}
