import 'package:ams_count/blocs/report/report_bloc.dart';
import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/config/app_data.dart';
import 'package:ams_count/models/count/countPlanModel.dart';
import 'package:ams_count/models/report/listCountDetail_report_model.dart';
import 'package:ams_count/widgets/alert.dart';
import 'package:ams_count/widgets/custom_card_report.dart';
import 'package:ams_count/widgets/custom_dropdown2.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../blocs/count/count_bloc.dart';
import '../../../data/models/api_response.dart';
import '../../../widgets/label.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<CountPlanModel> itemCountPlan = [];
  List<ListCountDetailReportModel> itemCountDetail = [];
  List<ListCountDetailReportModel> tempitemCountDetail = [];

  TextEditingController uncheck = TextEditingController();
  TextEditingController checked = TextEditingController();

  String valueselected = '';
  @override
  void initState() {
    BlocProvider.of<ReportBloc>(context)
        .add(GetListCountDetailForReportEvent(""));
    BlocProvider.of<CountBloc>(context).add(const GetListCountPlanEvent());
    super.initState();

    printInfo(info: "Test");
  }

  void _viewItem(String value) {
    List<ListCountDetailReportModel> searchResults = tempitemCountDetail
        .where((element) => element.STATUS_CHECK == value)
        .toList();
    if (searchResults.isNotEmpty) {
      itemCountDetail = searchResults;
    } else {
      itemCountDetail = tempitemCountDetail;
      AlertSnackBar.show(
          title: 'Data Invaild',
          message: ' Please Select View Again',
          type: ReturnStatus.WARNING,
          crossPage: true);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CountBloc, CountState>(listener: (context, state) async {
          if (state is GetListCountPlanLoadedState) {
            itemCountPlan = state.item;

            setState(() {});
          } else if (state is GetListCountPlanErrorState) {
            var itemSql = await CountPlanModel().queryAllRows();
            itemCountPlan =
                itemSql.map((item) => CountPlanModel.fromJson(item)).toList();
            printInfo(info: "${itemCountPlan.length}");
            setState(() {});
          }
        }),
        BlocListener<ReportBloc, ReportState>(listener: (context, state) async {
          if (state is GetListCountDetailLoadedState) {
            itemCountDetail = state.item;
            tempitemCountDetail = state.item;
            uncheck.text = itemCountDetail
                .where((element) =>
                    element.PLAN_CODE == valueselected &&
                    element.STATUS_CHECK == "Unchecked")
                .toList()
                .length
                .toString();
            checked.text = itemCountDetail
                .where((element) =>
                    element.PLAN_CODE == valueselected &&
                    element.STATUS_CHECK == "Checked")
                .toList()
                .length
                .toString();
            setState(() {});
          } else if (state is GetListCountDetailErrorState) {
            var itemSql = await ListCountDetailReportModel().query();
            itemCountDetail = itemSql
                .map((item) => ListCountDetailReportModel.fromJson(item))
                .where((element) => element.PLAN_CODE == valueselected)
                .toList();

            tempitemCountDetail = itemSql
                .map((item) => ListCountDetailReportModel.fromJson(item))
                .where((element) => element.PLAN_CODE == valueselected)
                .toList();
            uncheck.text = itemCountDetail
                .where((element) => element.STATUS_CHECK == "Unchecked")
                .toList()
                .length
                .toString();
            checked.text = itemCountDetail
                .where((element) => element.STATUS_CHECK == "Checked")
                .toList()
                .length
                .toString();
            setState(() {});
            printInfo(info: "UNcheck");
            setState(() {});
          }
        })
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => printInfo(info: "${valueselected}"),
              child: Label(
                "Report",
                fontSize: 18,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Stack(
              children: [
                Container(
                  color: colorPrimary,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: colorGreyLight.withOpacity(0.88),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Column(
                          children: [
                            itemCountDetail.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: itemCountDetail.length,
                                        itemBuilder: ((context, index) {
                                          return itemCountDetail[index]
                                                      .PLAN_CODE ==
                                                  valueselected
                                              ? CustomCardReport(
                                                  onTap: () async {
                                                    printInfo(
                                                        info:
                                                            "Test ${itemCountDetail[index].BEFORE_LOCATION_ID}");
                                                    var item =
                                                        await Get.toNamed(
                                                            '/ScanPage',
                                                            arguments: {
                                                          'planCode':
                                                              itemCountDetail[
                                                                      index]
                                                                  .PLAN_CODE,
                                                          'assetsCode':
                                                              itemCountDetail[
                                                                      index]
                                                                  .ASSET_CODE,
                                                          'locationID': itemCountDetail[
                                                                          index]
                                                                      .STATUS_CHECK !=
                                                                  "Checked"
                                                              ? itemCountDetail[
                                                                          index]
                                                                      .BEFORE_LOCATION_ID ??
                                                                  0
                                                              : null,
                                                          'departmentID': itemCountDetail[
                                                                          index]
                                                                      .STATUS_CHECK !=
                                                                  "Checked"
                                                              ? itemCountDetail[
                                                                          index]
                                                                      .BEFORE_DEPARTMENT_ID ??
                                                                  0
                                                              : null,
                                                          'statusName':
                                                              itemCountDetail[
                                                                          index]
                                                                      .STATUS_NAME ??
                                                                  "-",
                                                          'scanDate': itemCountDetail[
                                                                          index]
                                                                      .STATUS_CHECK !=
                                                                  "Unchecked"
                                                              ? DateFormat(
                                                                      "yyyy-MM-dd")
                                                                  .format(DateTime.parse(itemCountDetail[
                                                                          index]
                                                                      .CHECK_DATE
                                                                      .toString()))
                                                              : "-",
                                                          'name': itemCountDetail[
                                                                      index]
                                                                  .ASSET_NAME ??
                                                              "-",
                                                          'remark':
                                                              itemCountDetail[
                                                                          index]
                                                                      .REMARK ??
                                                                  "-",
                                                          'snNo': itemCountDetail[
                                                                      index]
                                                                  .ASSET_SERIAL_NO ??
                                                              "-",
                                                          'class': itemCountDetail[
                                                                      index]
                                                                  .CLASS_NAME ??
                                                              "-",
                                                          'use.date':
                                                              itemCountDetail[
                                                                          index]
                                                                      .ASSET_DATE_OF_USE ??
                                                                  "-",
                                                          'typePage':
                                                              "reportPage",
                                                          'statusCheck':
                                                              itemCountDetail[
                                                                          index]
                                                                      .STATUS_CHECK ??
                                                                  "-"
                                                        });

                                                    if (await item['GetBack'] !=
                                                        null) {
                                                      BlocProvider.of<
                                                                  ReportBloc>(
                                                              context)
                                                          .add(GetListCountDetailForReportEvent(
                                                              itemCountDetail[
                                                                      index]
                                                                  .PLAN_CODE
                                                                  .toString()));
                                                      BlocProvider.of<
                                                                  CountBloc>(
                                                              context)
                                                          .add(
                                                              const GetListCountPlanEvent());

                                                      printInfo(
                                                          info:
                                                              "Test Get Back ${itemCountDetail[index].PLAN_CODE.toString()}");
                                                      setState(() {});
                                                    }
                                                  },
                                                  item: itemCountDetail[index],
                                                )
                                              : SizedBox.shrink();
                                        })))
                                : const Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [],
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Wrap(
                    children: [
                      Card(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 8, left: 8, bottom: 8),
                          child: Column(
                            children: [
                              itemCountPlan.isNotEmpty
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: SizedBox(
                                              child: CustomDropdownButton2(
                                                hintText:
                                                    "Please Select Plan Code",
                                                items:
                                                    itemCountPlan.map((item) {
                                                  return DropdownMenuItem<
                                                      dynamic>(
                                                    value: item.PLAN_CODE,
                                                    child: Text(
                                                      "${item.PLAN_CODE}",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) async {
                                                  var itemListChecked =
                                                      await ListCountDetailReportModel()
                                                          .queryPlan(
                                                              plan: value);

                                                  int selectedIndex =
                                                      itemCountPlan.indexWhere(
                                                          (item) =>
                                                              item.PLAN_CODE ==
                                                              value);
                                                  if (selectedIndex >= 0 &&
                                                      selectedIndex <
                                                          itemCountPlan
                                                              .length) {
                                                    uncheck.text = itemListChecked
                                                        .where((element) =>
                                                            element[
                                                                'statusCheck'] ==
                                                            "Unchecked")
                                                        .toList()
                                                        .length
                                                        .toString();
                                                    checked.text = itemListChecked
                                                        .where((element) =>
                                                            element[
                                                                'statusCheck'] ==
                                                            "Checked")
                                                        .toList()
                                                        .length
                                                        .toString();
                                                    setState(() {});
                                                  }
                                                  // BlocProvider.of<ReportBloc>(
                                                  //         context)
                                                  //     .add(
                                                  //         GetListCountDetailForReportEvent(
                                                  //             ""));
                                                  BlocProvider.of<ReportBloc>(
                                                          context)
                                                      .add(
                                                          GetListCountDetailForReportEvent(
                                                              value));
                                                  itemCountDetail.clear();
                                                  valueselected = value;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : CircularProgressIndicator(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Label(
                                        "UnCheck : ",
                                        color: colorPrimary,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.bottom,
                                        style: TextStyle(fontSize: 26),
                                        controller: uncheck,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(4),
                                            filled: true,
                                            fillColor: Colors.transparent),
                                      )),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => _viewItem("Unchecked"),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: colorPrimary,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Center(child: Label("View")),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Label(
                                        "Check : ",
                                        color: colorPrimary,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.bottom,
                                        controller: checked,
                                        style: TextStyle(fontSize: 26),
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(4),
                                            filled: true,
                                            fillColor: Colors.transparent),
                                      )),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => _viewItem("Checked"),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: colorPrimary,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Center(child: Label("View")),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 15,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
