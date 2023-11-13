import 'package:flutter/cupertino.dart';
import '../../components/default_btn.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'contents.dart';


class ScreenBody extends StatefulWidget {
  const ScreenBody({super.key});

  @override
  _ScreenBodyState createState() => _ScreenBodyState();
}

class _ScreenBodyState extends State<ScreenBody> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Tokoto, Let’s shop!",
      "image": "assets/icons/demo_icon.png"
    },
    {
      "text":
      "We help people conect with store \naround United State of America",
      "image": "assets/icons/demo_icon.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/icons/demo_icon.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                            (index) => AnimatedContainer(
                          duration: kAnimationDuration,
                          margin: const EdgeInsets.only(right: 5),
                          height: 6,
                          width: currentPage == index ? 60 : 24,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? kPrimaryColor
                                : const Color(0xFFD8D8D8),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                    // DefaultButton(
                    //   text: "Continue",
                    //   press: () {
                    //     //Navigator.pushNamed(context, HomeScreen.routeName);
                    //   },
                    // ),
                   // const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}