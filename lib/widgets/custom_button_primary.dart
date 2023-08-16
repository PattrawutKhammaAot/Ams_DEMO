import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../config/app_constants.dart';

class CustomButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final Color color, textColor, iconColor;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final IconData? leading;
  final bool? hideLeadingIcon;
  final IconData? tailing;
  final TextAlign? textAlign;

  const CustomButtonPrimary({
    Key? key,
    required this.text,
    this.onPress,
    this.color = colorPrimary,
    this.textColor = Colors.white,
    this.iconColor = Colors.black87,
    this.height,
    this.padding,
    this.margin,
    this.width,
    this.leading,
    this.hideLeadingIcon = true,
    this.tailing,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: margin ?? const EdgeInsets.symmetric(vertical: 10),
        width: width ?? size.width * 0.85,
        height: height,
        //height: 52,
        child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: color,
            padding: padding ?? const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            // minimumSize: Size(40, 10),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Visibility(
              visible: !hideLeadingIcon!,
              child: FaIcon(
                leading ?? FontAwesomeIcons.angleRight,
                color: iconColor,
              ),
            ),
            const SizedBox(
              width: 0,
            ),
            Expanded(
              flex: 1,
              child: Text(
                text,
                textAlign: textAlign ?? TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  // fontSize: 14,
                  //   fontFamily: 'Noto',
                  //   fontFamilyFallback: <String>[
                  //   'Noto-Thai',
                  //   'Noto-Lao',
                  // ],
                ),
              ),
            ),
            Visibility(
              visible: tailing != null,
              child: tailing != null
                  ? FaIcon(
                tailing,
                color: iconColor,
              )
                  : const SizedBox(),
            ),
          ]),
        ));
  }
}
