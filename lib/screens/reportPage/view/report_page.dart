import 'package:ams_count/config/app_constants.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

import '../../../widgets/label.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding: const EdgeInsets.only(top: 80),
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
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            Expanded(
                                child: ListView.builder(
                                    itemCount: 50,
                                    itemBuilder: ((context, index) {
                                      return Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Label(
                                                "text",
                                                color: colorPrimary,
                                              ),
                                              Label(
                                                "text",
                                                color: colorPrimary,
                                              ),
                                              Label(
                                                "text",
                                                color: colorPrimary,
                                              ),
                                              Label(
                                                "text",
                                                color: colorPrimary,
                                              ),
                                              Label(
                                                "text",
                                                color: colorPrimary,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })))
                          ],
                        ),
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 0, right: 8, left: 8, bottom: 8),
                      child: Column(
                        children: [
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
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent),
                                  )),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: colorPrimary,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Center(child: Label("View")),
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
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent),
                                  )),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: colorPrimary,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Center(child: Label("View")),
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
    );
  }
}
