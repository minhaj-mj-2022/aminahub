import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../models/Products.dart';
import '../detailed_screen.dart';

class ProductCardCategory extends StatelessWidget {
  final List<Product> products;

  const ProductCardCategory(this.products, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.67,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(products[index]),
                ),
              );
            },
            child: buildProductCard(products[index]),
          );
        },
      ),
    );
  }

  Widget buildProductCard(Product product) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(2, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Image.asset(product.images[0]),
          ),
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price}",
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SvgPicture.asset(
                "assets/icons/Heart Icon_2.svg",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
