import 'package:ams_count/widgets/label.dart';
import 'package:flutter/material.dart';

import '../config/app_constants.dart';
import '../models/report/listCountDetail_report_model.dart';

class CustomCardReport extends StatelessWidget {
  CustomCardReport({super.key, this.onTap, required this.item});

  final Function()? onTap;

  ListCountDetailReportModel item = ListCountDetailReportModel();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Wrap(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Card(
                  elevation: 15,
                  color: Colors.white,
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: item.STATUS_CHECK == "Unchecked"
                          ? colorDanger
                          : colorActive,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 19,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: item.STATUS_CHECK == "Unchecked"
                                          ? colorDanger
                                          : colorActive,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(14)),
                                    ),
                                    child: Text(
                                      "${item.ASSET_CODE}",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    )),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Label("Name : ${item.ASSET_NAME}",
                                    maxLine: 3,
                                    color: colorPrimary,
                                    fontSize: 14),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Label(
                                    "Department : ${item.BEFORE_DEPARTMENT_NAME == 0.toString() || item.BEFORE_DEPARTMENT_NAME == null ? "-" : item.BEFORE_DEPARTMENT_NAME}",
                                    color: colorPrimary,
                                    fontSize: 14,
                                  ),
                                ),
                                Expanded(
                                    child: Label(
                                        "Location : ${item.BEFORE_LOCATION_NAME == 0.toString() || item.BEFORE_LOCATION_NAME == null ? "-" : item.BEFORE_LOCATION_NAME} ",
                                        color: colorPrimary,
                                        fontSize: 14)),
                                // Expanded(
                                //   child: Label(
                                //       "Count Status : ${item.STATUS_CHECK} ",
                                //       color: colorPrimary,
                                //       fontSize: 14),
                                // ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              item.STATUS_CHECK != "Unchecked"
                                  ? Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Label(
                                            "Status Name : ${item.STATUS_NAME ?? "-"} ",
                                            color: colorPrimary,
                                            fontSize: 14),
                                      ),
                                    )
                                  : Expanded(child: SizedBox.shrink()),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 21,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: item.STATUS_CHECK == "Unchecked"
                                          ? colorDanger
                                          : colorActive,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(14)),
                                    ),
                                    child: Text(
                                      "${item.STATUS_CHECK} ",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
