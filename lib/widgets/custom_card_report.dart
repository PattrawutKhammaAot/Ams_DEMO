import 'package:ams_count/widgets/label.dart';
import 'package:flutter/material.dart';

import '../config/app_constants.dart';

class CustomCardReport extends StatelessWidget {
  const CustomCardReport({
    super.key,
    this.onTap,
    this.assetCode,
    this.AssetName,
    this.checkDate,
    this.location,
    this.countDate,
    this.assetsStatus,
  });

  final Function()? onTap;
  final String? assetCode;
  final String? AssetName;
  final String? checkDate;
  final String? location;
  final String? countDate;
  final String? assetsStatus;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              elevation: 15,
              color: Colors.white,
              shape: OutlineInputBorder(
                borderSide: BorderSide(
                  color: assetsStatus == "Checked" ? colorActive : colorDanger,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 19,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: assetsStatus == "Checked"
                                  ? colorActive
                                  : colorDanger,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(14)),
                            ),
                            child: Text(
                              "Asset Code : ${assetCode ?? "-"}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Label(
                              "AssetName : ${AssetName ?? "-"} ",
                              color: colorPrimary,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Label(
                              "Location :  ${location ?? "-"}",
                              color: colorPrimary,
                            )),
                            assetsStatus == "Checked"
                                ? Label("Count Date : ${countDate ?? "-"} ",
                                    color: colorPrimary)
                                : Label(
                                    "Status Name : ",
                                    color: colorPrimary,
                                  ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 21,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: assetsStatus == "Checked"
                                    ? colorActive
                                    : colorDanger,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(12)),
                              ),
                              child: Label("${assetsStatus ?? "-"}",
                                  color: Colors.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 21,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: assetsStatus == "Checked"
                                      ? colorActive
                                      : colorDanger,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(14)),
                                ),
                                child: Text(
                                  "Qty :  10",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
