import '../../../imports.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image:
                    "https://firebasestorage.googleapis.com/v0/b/aminahub-18c2f.appspot.com/o/special_for_you%2Fbest-doctors.jpg?alt=media&token=74d12afe-d7dc-491b-93c9-1730042ef73e",
                category: "Get Qoutes",
                numOfAds: 18,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FullScreenImage(
                        image:
                            "https://firebasestorage.googleapis.com/v0/b/aminahub-18c2f.appspot.com/o/special_for_you%2Fbest-doctors.jpg?alt=media&token=74d12afe-d7dc-491b-93c9-1730042ef73e",
                      ),
                    ),
                  );
                },
                adsName: "Doctors",
              ),
              SpecialOfferCard(
                image:
                    "https://firebasestorage.googleapis.com/v0/b/aminahub-18c2f.appspot.com/o/special_for_you%2Fimprove-your-english.jpg?alt=media&token=07ec709a-9eed-4a83-a51d-e11b96306037",
                category: "Get Qoutes",
                numOfAds: 24,
                adsName: "Tutors",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FullScreenImage(
                        image:
                            "https://firebasestorage.googleapis.com/v0/b/aminahub-18c2f.appspot.com/o/special_for_you%2Fimprove-your-english.jpg?alt=media&token=07ec709a-9eed-4a83-a51d-e11b96306037",
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    super.key,
    required this.category,
    required this.image,
    required this.numOfAds,
    required this.press,
    required this.adsName,
  });

  final String category, image;
  final int numOfAds;
  final GestureTapCallback press;
  final String adsName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(260),
          height: getProportionateScreenWidth(150),
          child: Hero(
            tag: image,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF343434).withOpacity(0.4),
                          const Color(0xFF343434).withOpacity(0.15),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15.0),
                      vertical: getProportionateScreenWidth(10),
                    ),
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "$category\n",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: "$numOfAds $adsName")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String image;

  const FullScreenImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: image,
            child: Image.network(
              image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
