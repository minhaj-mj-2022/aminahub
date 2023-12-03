import 'package:aminahub/size_config.dart';
import '../../../imports.dart';

class ProductCarousal extends StatelessWidget {
  final List<Product> products;

  const ProductCarousal(this.products, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: SizedBox(
        height: getProportionateScreenHeight(355),
        width: SizeConfig.screenWidth,
        child: Stack(
          children: [
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              //itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(products[index]),
                      ),
                    );
                  },
                  child: buildProductCard(products[index]),
                );
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                //.filled
                icon: const Icon(Icons.arrow_forward_ios),
                color: Colors.blue,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductCard(Product product) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 2),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: const Color(0xFFE0F2F1),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.black12,
        //     spreadRadius: 0,
        //     blurRadius: 12,
        //     offset: Offset(5, 12),
        //     blurStyle: BlurStyle.outer
        //   ),
        // ],
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 9 / 16,
            child: Image.network(product.images[0]),
          ),
          const SizedBox(
            height: 2,
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "\$${product.price}",
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SvgPicture.asset(
              //   "assets/icons/Heart Icon_2.svg",
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
