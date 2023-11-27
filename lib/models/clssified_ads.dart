import 'package:aminahub/imports.dart';

class Product {
  final int id;
  final String heading, description, contactInfo, price;
  final List<String> images;

  Product({
    required this.id,
    required this.images,
    required this.heading,
    required this.price,
    required this.description,
    required this.contactInfo,
  });
}

class ProductService {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('ads');

  Future<List<Product>> getProducts() async {
    QuerySnapshot<Object?> querySnapshot =
        await productsCollection.get();

    List<Product> products = [];

    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;

      List<String> images = List<String>.from(data['images']);

      Product product = Product(
        id: data['id']?? 0,
        heading: data['heading']?? "No value",
        description: data['descriptions']?? "No value",
        contactInfo: data['contact']?? "No value",
        images: images, 
        price: data['price']?? "No value",
      );

      products.add(product);
    }

    return products;
  }
}
