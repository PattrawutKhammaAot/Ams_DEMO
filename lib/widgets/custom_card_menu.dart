import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:flutter/material.dart';

class CustomCardMenu extends StatelessWidget {
  const CustomCardMenu(
      {super.key,
      required this.text,
      required this.pathImage,
      required this.onTap});
  final String? text;
  final String? pathImage;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 100,
        child: Card(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide.none),
          color: colorPrimary,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 14, right: 4, left: 4, bottom: 14),
            child: Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Card(
                    shape: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/${pathImage}",
                          fit: BoxFit.fill,
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 3,
                  child: Label(
                    text!,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
