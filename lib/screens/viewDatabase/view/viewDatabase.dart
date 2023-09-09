import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/models/count/CountScan_output.dart';
import 'package:ams_count/screens/viewDatabase/view/modelview.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewDatabase extends StatefulWidget {
  const ViewDatabase({super.key});

  @override
  State<ViewDatabase> createState() => _ViewDatabaseState();
}

class _ViewDatabaseState extends State<ViewDatabase> {
  List<ViewDatabaseModel> listItem = [];
  @override
  void initState() {
    super.initState();

    _getDatabaseT_CountScanOutput().then((e) => true);
  }

  _getDatabaseT_CountScanOutput() async {
    printInfo(info: "test");
    var item = await CountScan_OutputModel().queryAllRows();
    listItem = item.map((e) => ViewDatabaseModel.fromJson(e)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Label("PageTest"),
      ),
      body: ListView.builder(
          itemCount: listItem.length,
          itemBuilder: (context, index) {
            return Card(
              color: listItem[index].STATUS_REQUEST == "Checked"
                  ? colorActive
                  : listItem[index].STATUS_REQUEST == "AlreadyChecked"
                      ? colorPrimary
                      : colorDanger,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label("Plan : ${listItem[index].PLAN_CODE}"),
                    Label("Asset : ${listItem[index].ASSETS_CODE}"),
                    Label("location : ${listItem[index].LOCATION_ID}"),
                    Label("department : ${listItem[index].DEPARTMENT_ID}"),
                    listItem[index].STATUS_REQUEST == "Checked"
                        ? Label(
                            "status : ${listItem[index].STATUS_REQUEST} : เปลี่ยนสถานะ จาก Unchecked",
                            maxLine: 10,
                          )
                        : listItem[index].STATUS_REQUEST == "AlreadyChecked"
                            ? Label(
                                "status : ${listItem[index].STATUS_REQUEST} จากสถานะ Checked ที่มีการ  เช็คอยู่ในระบบแล้ว",
                                maxLine: 10,
                              )
                            : Label(
                                "status : ${listItem[index].STATUS_REQUEST} ไม่มีอยู่ในแผน นั้นๆ",
                                maxLine: 10,
                              ),
                    Label(
                      "CheckDate :${listItem[index].CHECK_DATE}",
                      maxLine: 10,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
