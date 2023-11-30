import 'package:aminahub/imports.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen(this.product, {super.key});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _currentImageIndex = 0;
  
  // Function to add item to bookmarks
  void addToBookmark() {
    FirebaseFirestore.instance
        .collection("Bookmarks")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .add({
      "title": widget.product.title,
      "ads_id": widget.product.id,
      "images": widget.product.images,
      "price": widget.product.price,
      "description": widget.product.description,
      "contactInfo": widget.product.contactInfo,
      "location_state": widget.product.location_state,
      // Add other fields as needed
    });
  }

  // Function to remove item from bookmarks
  void removeFromBookmark() {
    FirebaseFirestore.instance
        .collection("Bookmarks")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .where("title", isEqualTo: widget.product.title)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
        title: Text(widget.product.title),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Bookmarks")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items")
                .where("title", isEqualTo: widget.product.title)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              bool isBookmarked = snapshot.data?.docs.isNotEmpty ?? false;
              return IconButton(
                icon: Icon(
                  isBookmarked ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 40,
                ),
                onPressed: () {
                  isBookmarked ? removeFromBookmark() : addToBookmark();
                },
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/aminahub.png',
              height: getProportionateScreenHeight(60),
            ),
           SizedBox(height: getProportionateScreenWidth(15)),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImageView(
                      images: widget.product.images,
                      initialIndex: _currentImageIndex,
                    ),
                  ),
                );
              },
              child: CarouselSlider(
                items: widget.product.images.map((image) {
                  return Image.network(image);
                }).toList(),
                options: CarouselOptions(
                  height: getProportionateScreenHeight(450),
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 9/16,
                  enableInfiniteScroll: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeFactor: 0.2,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            DotsIndicator(
              dotsCount: widget.product.images.length,
              position: _currentImageIndex,
              decorator: DotsDecorator(
                activeColor: Colors.blue,
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(25), right: 30, bottom: getProportionateScreenWidth(25)),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10),),
                  Text(
                    "\$ ${widget.product.price}",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5),),
                  const Divider(
                    thickness: 5,
                    color: Color(0xFFFAAB37),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10),),
                  Text(
                    "\📍 ${widget.product.location_state}",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    thickness: 5,
                    color: Color(0xFFFAAB37),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10),),
                  const Text(
                    "Descriptions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ReadMoreText(
                    widget.product.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16
                    ),
                    trimLines: 5,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5),),
                  const Divider(
                    thickness: 5,
                    color: Color(0xFFFAAB37),
                  ),
                  const Text(
                    "Contact Info.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.product.contactInfo,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  FullScreenImageView({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(images[index]),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        pageController: PageController(initialPage: initialIndex),
        onPageChanged: (index) {
          // Handle page change if needed
        },
      ),
    );
  }
}
