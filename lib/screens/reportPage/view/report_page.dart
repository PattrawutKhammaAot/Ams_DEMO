import 'package:ams_count/blocs/report/report_bloc.dart';
import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/models/count/countPlanModel.dart';
import 'package:ams_count/models/report/listCountDetail_report_model.dart';
import 'package:ams_count/widgets/custom_card_report.dart';
import 'package:ams_count/widgets/custom_dropdown2.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../blocs/count/count_bloc.dart';
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
  @override
  void initState() {
    BlocProvider.of<CountBloc>(context).add(const GetListCountPlanEvent());
    super.initState();
  }

  void _viewItem(String value) {
    List<ListCountDetailReportModel> searchResults = tempitemCountDetail
        .where((element) => element.STATUS_CHECK == value)
        .toList();
    if (searchResults.isNotEmpty) {
      itemCountDetail = searchResults;
    } else {
      itemCountDetail = tempitemCountDetail;
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

            printInfo(info: "${itemCountPlan.length}");
          } else if (state is GetListCountPlanErrorState) {
            var itemSql = await CountPlanModel().queryAllRows();
            itemCountPlan =
                itemSql.map((item) => CountPlanModel.fromJson(item)).toList();
            setState(() {});
          }
        }),
        BlocListener<ReportBloc, ReportState>(listener: (context, state) async {
          if (state is GetListCountDetailLoadedState) {
            if (state.item.isNotEmpty) {
              itemCountDetail = state.item;
              tempitemCountDetail = state.item;
            } else {
              itemCountDetail.clear();
            }
            setState(() {});
          } else if (state is GetListCountDetailErrorState) {}
        })
      ],
      child: Scaffold(
        appBar: EasySearchBar(
            elevation: 10,
            title: Align(
              alignment: Alignment.centerLeft,
              child: Label(
                "Report",
                fontSize: 18,
              ),
            ),
            onSearch: (value) {}),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: colorPrimary,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Text(""),
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
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: itemCountDetail.length,
                                      itemBuilder: ((context, index) {
                                        return CustomCardReport(
                                          assetCode:
                                              itemCountDetail[index].ASSET_CODE,
                                          AssetName:
                                              itemCountDetail[index].ASSET_NAME,
                                          assetsStatus: itemCountDetail[index]
                                              .STATUS_CHECK,
                                          countDate: itemCountDetail[index]
                                              .CHECK_DATE
                                              .toString(),
                                        );
                                      })))
                            ],
                          ),
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Card(
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: CustomDropdownButton2(
                                            hintText: "Please Select Plan Code",
                                            items: itemCountPlan.map((item) {
                                              return DropdownMenuItem<dynamic>(
                                                value: item.PLAN_CODE,
                                                child: Text(
                                                  "${item.PLAN_CODE}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              int selectedIndex = itemCountPlan
                                                  .indexWhere((item) =>
                                                      item.PLAN_CODE == value);
                                              if (selectedIndex >= 0 &&
                                                  selectedIndex <
                                                      itemCountPlan.length) {
                                                uncheck.text =
                                                    itemCountPlan[selectedIndex]
                                                        .UNCHECK
                                                        .toString();
                                                checked.text =
                                                    itemCountPlan[selectedIndex]
                                                        .CHECK
                                                        .toString();
                                              }
                                              BlocProvider.of<ReportBloc>(
                                                      context)
                                                  .add(
                                                      GetListCountDetailForReportEvent(
                                                          value));
                                            },
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
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
