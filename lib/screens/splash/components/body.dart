
import 'package:aminahub/database/data_fetch.dart';
import 'package:aminahub/screens/home/home_screen.dart';
import 'package:aminahub/screens/splash/components/splash_Content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../components/default_btn.dart';
import '../../../constants.dart';
import '../../../size_config.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "is the place \nof all the needs \nin One stop \ndestinations...",
    },
    {
      "text":
      "with expart \nservice professionals...\n",
    },
    {
      "text": "where user \nget their \nneeds fullfilled\n and delited.",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xfff5e3cc4),
        child: SizedBox(
          //width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    text: splashData[index]['text'],
                    logo: 'assets/images/aminahub_splash_screen_logo.png'
                  ),
                ),
              ),
              Expanded(
                flex: 2,
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
                            margin: const EdgeInsets.only(right: 6),
                            height: 8,
                            width: currentPage == index ? 30 : 9,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? kPrimaryColor
                                  : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      DefaultButton(
                        text: "Continue",
                        press: () {
                          //Navigator.pushNamed(context, SignInScreen.routeName);
                          //Navigator.pushNamed(context, SignInScreen.routeName);
                          Navigator.pushNamed(context, HomeScreen.routeName);
                          //Navigator.pushNamed(context, DataFetchScreen.routeName);

                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


