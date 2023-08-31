import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:flutter/material.dart';

class CustomCardMenu extends StatelessWidget {
  const CustomCardMenu(
      {super.key,
      required this.text,
      required this.pathImage,
      required this.onTap,
      this.backgroundColor});
  final String? text;
  final String? pathImage;
  final Function()? onTap;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Card(
          elevation: 0,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide.none),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: backgroundColor,
                        radius: 50,
                      ),
                      Image.asset(
                        "assets/images/${pathImage}",
                        fit: BoxFit.cover,
                        width: 40,
                      )
                    ],
                  ),
                ),
                Label(
                  "${text}",
                  color: colorPrimary,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
