import 'package:flutter/material.dart';

import '../config/app_constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color backColor;
  final double? height;

  const TextFieldContainer({
    Key? key,
    required this.child,
    this.backColor = colorLight, this.height = 42
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      padding: const EdgeInsets.only(left: 0, top: 1, right: 10, bottom: 1),
      width: size.width * 1,
       height: height,
      // decoration: BoxDecoration(
      //    // color: backColor,
      //   // borderRadius: BorderRadius.circular(10),
      //   //   boxShadow: const [
      //   //     BoxShadow(
      //   //       color: Color.fromRGBO(31, 84, 195, 0.18),
      //   //       spreadRadius: 0,
      //   //       blurRadius: 8,
      //   //       offset: Offset(0, 1),
      //   //     )
      //   //   ],
      //
      // ),
      child: child,
    );
  }
}
