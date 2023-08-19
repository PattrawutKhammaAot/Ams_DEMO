import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/widgets/custom_dropdown2.dart';
import 'package:ams_count/widgets/custom_textfield.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:ams_count/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _barcodeFocusNode = FocusNode();
  FocusNode _assetNoFocusNode = FocusNode();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _serialNumberFocusNode = FocusNode();
  FocusNode _classFocusNode = FocusNode();
  FocusNode _usedateFocusNode = FocusNode();
  FocusNode _remarkFocusNode = FocusNode();
  FocusNode _scandateFocusNode = FocusNode();
  FocusNode _statusFocusNode = FocusNode();

  TextEditingController scanDate = TextEditingController();
  TextEditingController _barcodeController = TextEditingController();
  TextEditingController _assetNoController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _serialNumberController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _useDateController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  String? selectedValue;

  dynamic _validate(String values, FocusNode focus) {
    if (values.isEmpty) {
      focus.requestFocus();
      return "Please Input Field";
    } else {
      print("NotEmpty");
      focus.requestFocus();
      return null;
    }
  }

  @override
  void initState() {
    _barcodeFocusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String result = '';
    scanDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return Form(
      key: _formKey,
      child: Scaffold(
        // extendBody: true,
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Label("Scan Count"),
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              padding: EdgeInsets.only(
                top: 0,
                left: 15,
                right: 30,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Label("Department :")),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 0, right: 10, left: 10, bottom: 10),
                            child: SizedBox(
                              child: CustomDropdownButton2(
                                hintText: "Selected Department",
                                items: items
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  selectedValue = value;
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Label("Location :")),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 0, right: 8, left: 8, bottom: 10),
                            child: SizedBox(
                              child: CustomDropdownButton2(
                                hintText: "Selected Location",
                                items: items
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  selectedValue = value;
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 15, left: 20, right: 20),

                  // color: Colors.grey.withOpacity(0.5),
                  child: Column(
                    children: [
                      CustomTextInputField(
                        labelText: "Barcode",
                        focusNode: _barcodeFocusNode,
                        onFieldSubmitted: (value) =>
                            _validate(value, _assetNoFocusNode),
                        controller: _barcodeController,
                        isHideLable: true,
                        validator: (value) =>
                            _validate(value!, _barcodeFocusNode),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              var res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SimpleBarcodeScannerPage(),
                                  ));
                              setState(() {
                                if (res is String) {
                                  _barcodeController.text = res;
                                }
                              });
                            },
                            icon: Icon(Icons.qr_code)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextInputField(
                        onFieldSubmitted: (value) =>
                            _validate(value, _statusFocusNode),
                        isHideLable: true,
                        labelText: "Asset No",
                        focusNode: _assetNoFocusNode,
                        controller: _assetNoController,
                        validator: (value) =>
                            _validate(value!, _assetNoFocusNode),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomDropdownButton2(
                        focusNode: _statusFocusNode,
                        labelText: "Status",
                        items: items
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          selectedValue = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextInputField(
                        isHideLable: true,
                        labelText: "Name",
                        onFieldSubmitted: (value) =>
                            _validate(value, _serialNumberFocusNode),
                        focusNode: _nameFocusNode,
                        controller: _nameController,
                        validator: (value) => _validate(value!, _nameFocusNode),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextInputField(
                        isHideLable: true,
                        onFieldSubmitted: (value) =>
                            _validate(value, _classFocusNode),
                        labelText: "Serial Number",
                        focusNode: _serialNumberFocusNode,
                        controller: _serialNumberController,
                        validator: (value) =>
                            _validate(value!, _serialNumberFocusNode),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextInputField(
                        isHideLable: true,
                        onFieldSubmitted: (value) =>
                            _validate(value, _usedateFocusNode),
                        labelText: "Class",
                        focusNode: _classFocusNode,
                        controller: _classController,
                        validator: (value) =>
                            _validate(value!, _classFocusNode),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextInputField(
                        isHideLable: true,
                        labelText: "Use.Date",
                        onFieldSubmitted: (value) =>
                            _validate(value, _remarkFocusNode),
                        focusNode: _usedateFocusNode,
                        controller: _useDateController,
                        validator: (value) =>
                            _validate(value!, _usedateFocusNode),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextInputField(
                              onFieldSubmitted: (value) {},
                              focusNode: _remarkFocusNode,
                              isHideLable: true,
                              labelText: "Remark",
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: CustomTextInputField(
                              isHideLable: true,
                              labelText: "ScanDate",
                              controller: scanDate,
                              readOnly: true,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, right: 8, left: 8),
                              child: CustomButtonPrimary(
                                height: 55,
                                text: "Save",
                                hideLeadingIcon: false,
                                leading: LineIcons.save,
                                iconColor: Colors.white,
                                color: colorActive,
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {}
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, right: 8, left: 8),
                              child: CustomButtonPrimary(
                                height: 55,
                                text: "Camera",
                                hideLeadingIcon: false,
                                leading: LineIcons.camera,
                                iconColor: Colors.white,
                                color: colorWarning,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Row(
            //   children: [
            //     SizedBox(
            //       height: 15,
            //     ),
            //     Expanded(
            //       child: Padding(
            //         padding: const EdgeInsets.only(top: 0, right: 8, left: 8),
            //         child: CustomButtonPrimary(
            //           height: 55,
            //           text: "Save",
            //           hideLeadingIcon: false,
            //           leading: LineIcons.save,
            //           iconColor: Colors.white,
            //           color: colorActive,
            //           onPress: () {
            //             if (_formKey.currentState!.validate()) {}
            //           },
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: Padding(
            //         padding: const EdgeInsets.only(top: 0, right: 8, left: 8),
            //         child: CustomButtonPrimary(
            //           height: 55,
            //           text: "Camera",
            //           hideLeadingIcon: false,
            //           leading: LineIcons.camera,
            //           iconColor: Colors.white,
            //           color: colorWarning,
            //         ),
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
