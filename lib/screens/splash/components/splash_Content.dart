import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';

//test git
class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.logo,
  }) : super(key: key);
  final String? text, logo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Image.asset(
          logo!,
          height: getProportionateScreenHeight(60),
          width: getProportionateScreenWidth(190),
        ),
        SizedBox(
            width: 200,
            child: EasyRichText(
                  text!,
                  patternList: [
                    EasyRichTextPattern(
                      targetString: ['One', 'stop', 'destinations...',
                      'service','professionals...',
                      'needs fullfilled'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white,
                        ),
                    ),
                    EasyRichTextPattern(
                      targetString: ['is the place', 'of all the needs', 'in',
                      'with expart','where user','get their','needs fullfilled','and delited.'],
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        ),
                    )
                  ],
                ),
        ),
      ],
    );
  }
}
