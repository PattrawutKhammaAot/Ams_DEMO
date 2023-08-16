import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../config/config.dart';

class Loading {
  static void showLoading({bool? showDefaultText = false, String? text}) {
    BotToast.showCustomLoading(
        toastBuilder: (_) => CustomLoading(
            text: (text ?? (showDefaultText! ? '' : ''))));
  }

  //
  // showDialog(
  // context: context,
  // barrierDismissible: false,
  // builder: (BuildContext context) {
  // return WillPopScope(
  // onWillPop: () async => false,
  // child: AlertDialog(
  // shape: RoundedRectangleBorder(
  // borderRadius: BorderRadius.all(Radius.circular(8.0))
  // ),
  // backgroundColor: Colors.black87,
  // content: LoadingIndicator(
  // text: text
  // ),
  // )
  // );
  // },
  // );

  static void closeAllLoading() {
    BotToast.closeAllLoading();
  }
}

class CustomLoading extends StatelessWidget {
  final String? text;

  const CustomLoading({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          //color: Colors.white30,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Lottie.asset(
            'assets/lottie_files/7379-gears-animation.zip',
            //height: size.height * 0.35,
            height: MediaQuery.of(context). size.height * 0.25,
          ),
          text == null || text!.isEmpty
              ? const SizedBox(
                  height: 0,
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    text!,
                    style: const TextStyle(color: colorPrimary),
                  ),
                ),
        ],
      ),
    );
  }
}
