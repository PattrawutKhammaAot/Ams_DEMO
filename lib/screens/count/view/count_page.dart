import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_range_pointer.dart';

class CountPage extends StatefulWidget {
  const CountPage({super.key});

  @override
  State<CountPage> createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: Text(
          "List Count",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 5,
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            Label(
                              "Total",
                              color: colorPrimary,
                            ),
                            Label(
                              "100",
                              color: colorPrimary,
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          CustomRangePoint(
                            valueRangePointer: 25,
                            allItem: 100,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Label(
                            "Uncheck",
                            color: colorPrimary,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomRangePoint(
                            valueRangePointer: 25,
                            allItem: 100,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Label(
                            "Check",
                            color: colorPrimary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 15,
                        color: Colors.white,
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: colorGreenDark),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Code :"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Details : "),
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Date :"),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                            width: 150,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 21,
                                              vertical: 7,
                                            ),
                                            decoration: const BoxDecoration(
                                              color: colorActive,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  bottomRight:
                                                      Radius.circular(14)),
                                            ),
                                            child: Text(
                                              "Counting",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // ListView.builder(
          //   itemCount: 50,
          //   itemBuilder: (context, index) {
          //     return Card(
          //       child: Text("data"),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
