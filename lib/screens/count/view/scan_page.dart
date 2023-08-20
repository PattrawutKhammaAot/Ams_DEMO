import 'dart:io';

import 'package:ams_count/blocs/count/count_bloc.dart';
import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/models/master/departmentModel.dart';
import 'package:ams_count/models/master/locationModel.dart';
import 'package:ams_count/models/master/statusAssetCountModel.dart';
import 'package:ams_count/widgets/custom_dropdown2.dart';
import 'package:ams_count/widgets/custom_textfield.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:ams_count/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _statusController = TextEditingController();

  List<LocationModel> _locationModel = [];
  List<DepartmentModel> _departmentModel = [];
  List<StatusAssetCountModel> _statusAssetCountModel = [];

  File? imageFile;

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
    BlocProvider.of<CountBloc>(context).add(const GetLocationEvent());
    BlocProvider.of<CountBloc>(context).add(const GetDepartmentEvent());
    BlocProvider.of<CountBloc>(context).add(const GetStatusAssetsCountEvent());
    _barcodeFocusNode.requestFocus();
    super.initState();
  }

  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    String result = '';
    scanDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return MultiBlocListener(
      listeners: [
        BlocListener<CountBloc, CountState>(listener: (context, state) async {
          if (state is GetLocationLoadedState) {
            _locationModel = state.item;
          }
          if (state is GetDepartmentLoadedState) {
            _departmentModel = state.item;
          }
          if (state is GetStatusAssetLoadedState) {
            _statusAssetCountModel = state.item;
          }
          setState(() {});
        })
      ],
      child: Form(
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
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Label("Department :")),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                child: CustomDropdownButton2(
                                  hintText: "Selected Department",
                                  items: _departmentModel
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item.DEPARTMENT_NAME,
                                            child: Text(
                                              item.DEPARTMENT_NAME ?? "",
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    _departmentController.text = value ?? "-";
                                  },
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
                              child: SizedBox(
                                child: CustomDropdownButton2(
                                  hintText: "Selected Location",
                                  items: _locationModel
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item.LOCATION_NAME,
                                            child: Text(
                                              item.LOCATION_NAME ?? "",
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    _locationController.text = value ?? "-";
                                  },
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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
                          items: _statusAssetCountModel
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.STATUS_NAME,
                                    child: Text(
                                      item.STATUS_NAME ?? "-",
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            _statusController.text = value ?? "-";
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
                          validator: (value) =>
                              _validate(value!, _nameFocusNode),
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
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            imageFile != null
                                ? Image.file(
                                    imageFile ?? File(""),
                                    width: 150,
                                    height: 150,
                                  )
                                : Label("No File")
                          ],
                        ),
                        SizedBox(
                          height: 5,
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
                                  onPress: () => _getFromCamera(),
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
            ],
          ),
        ),
      ),
    );
  }
}
