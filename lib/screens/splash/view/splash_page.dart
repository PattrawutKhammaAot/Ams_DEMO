
import 'package:flutter/material.dart';

import '../../../config/app_constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    //Loading.showLoading(showDefaultText: false);

    return Scaffold(

      backgroundColor: colorBackgroundGray,
      body: Stack(children: [
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            //image: DecorationImage(image: AssetImage("assets/images/bg_splash.png"), fit: BoxFit.cover),
            color: Colors.white
          ),
        ),
        Center(
            child: Image.asset(
          "assets/images/test.png",
          width: MediaQuery.of(context).size.width * 0.35,
        )),
      ]),
    );
  }
}
