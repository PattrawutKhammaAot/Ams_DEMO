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
        child: Card(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide.none),
          color: colorPrimary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: Image.asset(
                      "assets/images/${pathImage}",
                      fit: BoxFit.fill,
                      width: 50,
                    ),
                  ),
                ),
                Label("${text}")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
