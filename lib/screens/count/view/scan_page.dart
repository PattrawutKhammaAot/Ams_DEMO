// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ams_count/app.dart';
import 'package:ams_count/blocs/count/count_bloc.dart';
import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/config/app_data.dart';
import 'package:ams_count/models/count/countScanAssetsModel.dart';
import 'package:ams_count/models/count/uploadImage_output_Model.dart';
import 'package:ams_count/models/master/departmentModel.dart';
import 'package:ams_count/models/master/locationModel.dart';
import 'package:ams_count/models/master/statusAssetCountModel.dart';

import 'package:ams_count/widgets/custom_dropdown2.dart';
import 'package:ams_count/widgets/custom_textfield.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:ams_count/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../data/database/dbsqlite.dart';
import '../../../data/models/api_response.dart';
import '../../../models/count/CountScan_output.dart';
import '../../../models/count/listImageAssetModel.dart';
import 'package:ams_count/widgets/alert.dart' as AlertDialog1;

import '../../../widgets/alert_new.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final _formKey = GlobalKey<FormState>();
  final _dropdownKey = GlobalKey<FormState>();
  FocusNode _barcodeFocusNode = FocusNode();
  FocusNode _assetNoFocusNode = FocusNode();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _serialNumberFocusNode = FocusNode();
  FocusNode _classFocusNode = FocusNode();
  FocusNode _usedateFocusNode = FocusNode();
  FocusNode _remarkFocusNode = FocusNode();
  FocusNode _scandateFocusNode = FocusNode();
  FocusNode _statusFocusNode = FocusNode();
  FocusNode _locationFocusNode = FocusNode();
  FocusNode _departmenFocusNode = FocusNode();

  TextEditingController scanDate = TextEditingController();
  TextEditingController _barCodeController = TextEditingController();
  TextEditingController _assetNoController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _serialNumberController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _useDateController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  final List<GlobalObjectKey<FormState>> formKeyList =
      List.generate(10, (index) => GlobalObjectKey<FormState>(index));
  int statusId = 0;
  int departmentId = 0;
  int locationId = 0;
  String _scanDate = "";
  String? planCode;
  String? error;
  List<LocationModel> _locationModel = [];
  List<DepartmentModel> _departmentModel = [];
  List<StatusAssetCountModel> _statusAssetCountModel = [];
  CountScanAssetsModel itemCountListModel = CountScanAssetsModel();
  CountScanAssetsModel itemCountModel = CountScanAssetsModel();
  var arguments = Get.arguments as Map<String, dynamic>?;
  File? imageFile;
  bool isCheckdropdown = false;
  String? selectedValue;

  dynamic _validate(String values, FocusNode focus) {
    if (values.isEmpty) {
      focus.requestFocus();
      return "Please Input Field";
    } else {
      focus.requestFocus();
      return null;
    }
  }

  void _validateDropdown() {
    if (_departmentController.text.isEmpty &&
        _locationController.text.isEmpty) {
      formKeyList[1].currentState!.validate();
    } else if (_locationController.text.isEmpty &&
            _departmentController.text.isNotEmpty ||
        _departmentController.text.isEmpty &&
            _locationController.text.isNotEmpty ||
        _departmentController.text.isNotEmpty &&
            _locationController.text.isNotEmpty) {
      formKeyList[1].currentState!.validate();
      isCheckdropdown = true;
      setState(() {});
    } else {
      print(_departmentController.text);
      print(_locationController.text);
    }
  }

  Future _buttonSave() async {
    if (formKeyList[0].currentState!.validate() &&
        formKeyList[1].currentState!.validate()) {
      if (_departmentController.text.isNotEmpty ||
          _locationController.text.isNotEmpty) {
        if (await AppData.getMode() == "Offline") {
          await CountScan_OutputModel().insert(CountScan_OutputModel(
              ASSETS_CODE: _barCodeController.text.trim(),
              PLAN_CODE: planCode,
              LOCATION_ID: locationId,
              DEPARTMENT_ID: departmentId,
              IS_SCAN_NOW: true,
              REMARK: _remarkController.text.isEmpty
                  ? "-"
                  : _remarkController.text.trim(),
              STATUS_ID: statusId));
          AlertWarningNew().alertShowOK(context,
              title: "Save Success",
              desc: "",
              type: AlertType.success, onPress: () {
            _assetNoController.clear();
            _nameController.clear();
            _serialNumberController.clear();
            _classController.clear();
            _useDateController.clear();
            _barCodeController.clear();
            _remarkController.clear();
            _barcodeFocusNode.requestFocus();
            Navigator.pop(context);
          });
        } else {
          BlocProvider.of<CountBloc>(context).add(PostCountScanSaveAssetEvent(
              CountScan_OutputModel(
                  ASSETS_CODE: _barCodeController.text.trim(),
                  PLAN_CODE: planCode,
                  LOCATION_ID: locationId,
                  DEPARTMENT_ID: departmentId,
                  IS_SCAN_NOW: true,
                  REMARK: _remarkController.text.isEmpty
                      ? "-"
                      : _remarkController.text.trim(),
                  STATUS_ID: statusId)));
        }
      }
    }
  }

  @override
  void initState() {
    BlocProvider.of<CountBloc>(context).add(const GetLocationEvent());
    BlocProvider.of<CountBloc>(context).add(const GetDepartmentEvent());
    BlocProvider.of<CountBloc>(context).add(const GetStatusAssetsCountEvent());
    _barcodeFocusNode.requestFocus();
    _barcodeFocusNode.requestFocus();
    _loadDataFormReportPage().then((item) {
      _requestApiFirstTime();
    });
    super.initState();
  }

  _uploadPhotoToServer() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1200,
      maxHeight: 1200,
    );
    if (pickedFile != null) {
      imageFile = await File(pickedFile.path);

      BlocProvider.of<CountBloc>(context).add(UploadImageEvent(
          UploadImageModelOutput(
              ASSETS_CODE: _barCodeController.text.toUpperCase(),
              FILES: imageFile!)));
      setState(() {});
    }
  }

  _uploadPhotoToSqlite() async {
    var path = await getExternalStorageDirectory();
    String randomFileName = Random().nextInt(1000000).toString();
    final File newImage =
        await imageFile!.copy('${path!.path}/${randomFileName}.jpg');

    if (newImage != null) {
      await ListImageAssetModel().insert(ListImageAssetModel(
          ASSETS_CODE: _barCodeController.text, URL_IMAGE: newImage.path));
      AlertWarningNew().alertShowOK(context,
          title: "Save Success",
          desc: "Internet Offline Save Image to Local",
          type: AlertType.success, onPress: () {
        _assetNoController.clear();
        _nameController.clear();
        _serialNumberController.clear();
        _classController.clear();
        _useDateController.clear();
        _barCodeController.clear();
        _barcodeFocusNode.requestFocus();

        Navigator.pop(context);
      });
    }
  }

  _loadDataFormReportPage() async {
    planCode = arguments?['planCode'] ?? "Please Select Plan";

    if (arguments?['typePage'] == "reportPage") {
      locationId = arguments?['locationID'] ?? 0;
      departmentId = arguments?['departmentID'] ?? 0;
      scanDate.text =
          arguments?['scanDate'] == "" ? "-" : arguments?['scanDate'];

      _barCodeController.text =
          arguments?['assetsCode'] ?? _barCodeController.text;
    } else {
      scanDate.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
    }

    _departmentController.text = departmentId.toString();
    _locationController.text = locationId.toString();
    _statusController.text = statusId.toString();
    setState(() {});
  }

  _requestApiFirstTime() {
    if (_barCodeController.text.isNotEmpty) {
      BlocProvider.of<CountBloc>(context).add(PostCountScanAssetListEvent([
        CountScan_OutputModel(
            ASSETS_CODE: _barCodeController.text.trim(),
            PLAN_CODE: planCode,
            LOCATION_ID: locationId,
            DEPARTMENT_ID: departmentId,
            IS_SCAN_NOW: true,
            REMARK: _remarkController.text.isEmpty
                ? "-"
                : _remarkController.text.trim(),
            STATUS_ID: statusId)
      ]));
      // BlocProvider.of<CountBloc>(context).add(PostCountScanAlreadyCheckEvent(
      //     CountScan_OutputModel(
      //         ASSETS_CODE: _assetNoController.text,
      //         PLAN_CODE: planCode,
      //         LOCATION_ID: locationId,
      //         DEPARTMENT_ID: departmentId,
      //         IS_SCAN_NOW: true,
      //         STATUS_ID: statusId,
      //         REMARK: _remarkController.text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    // scanDate.text = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    return MultiBlocListener(
      listeners: [
        BlocListener<CountBloc, CountState>(listener: (context, state) async {
          if (state is GetLocationLoadedState) {
            await DbSqlite()
                .deleteAll(tableName: '${LocationField.TABLE_NAME}');
            for (var item in state.item) {
              await LocationModel().insert(item.toJson());
            }
            _locationModel = state.item;
          } else if (state is GetLocationErrorState) {
            var itemSql = await LocationModel().query();
            _locationModel =
                itemSql.map((map) => LocationModel.fromJson(map)).toList();
          }
          if (state is GetDepartmentLoadedState) {
            _departmentModel = state.item;
            await DbSqlite()
                .deleteAll(tableName: '${DepartmentField.TABLE_NAME}');
            for (var item in state.item) {
              await DepartmentModel().insert(item.toJson());
            }
          } else if (state is GetDepartmentErrorState) {
            var itemSql = await DepartmentModel().query();
            _departmentModel =
                itemSql.map((map) => DepartmentModel.fromJson(map)).toList();
          }
          if (state is GetStatusAssetLoadedState) {
            await DbSqlite()
                .deleteAll(tableName: '${StatusAssetField.TABLE_NAME}');
            for (var item in state.item) {
              await StatusAssetCountModel().insert(item);
            }
            _statusAssetCountModel = state.item;
          } else if (state is GetStatusAssetErrorState) {
            var itemSql = await StatusAssetCountModel().query();
            _statusAssetCountModel = itemSql
                .map((map) => StatusAssetCountModel.fromJson(map))
                .toList();
          }

          if (state is CountScanAssetsListLoadedState) {
            var data = state.item.DATA;

            error = state.item.MESSAGE;
            if (state.item.STATUS == "SUCCESS") {
              itemCountListModel = CountScanAssetsModel.fromJson(data);
              _serialNumberController.text =
                  itemCountListModel.ASSET_SERIALNO ?? "-";
              _nameController.text = itemCountListModel.ASSETNAME ?? "-";
              _classController.text = itemCountListModel.CLASSNAME ?? "-";
              _remarkController.text = itemCountListModel.REMARK ?? "";
              _assetNoController.text = itemCountListModel.ASSET_CODE ?? "";

              _serialNumberController.text =
                  itemCountListModel.ASSET_SERIALNO ?? "";
              _useDateController.text =
                  itemCountListModel.ASSET_DATEOFUSE ?? "-";
              DateTime? parsedDate = DateTime.tryParse(_useDateController.text);
              String formattedDate = parsedDate != null
                  ? DateFormat("yyyy-MM-dd").format(parsedDate)
                  : "-";
              _useDateController.text = formattedDate;

              setState(() {});
            }
            if (state.item.MESSAGE ==
                'สินทรัพย์นี้ได้ถูกตรวจนับแล้ว ต้องการตรวจเช็คซ้ำหรือไม่') {
              AlertWarningNew().alertShow(context,
                  type: AlertType.warning,
                  title: "Warning",
                  desc: "${error}", onPress: () {
                BlocProvider.of<CountBloc>(context).add(
                    PostCountScanAlreadyCheckEvent(CountScan_OutputModel(
                        ASSETS_CODE: _assetNoController.text,
                        PLAN_CODE: planCode,
                        LOCATION_ID: locationId,
                        DEPARTMENT_ID: departmentId,
                        IS_SCAN_NOW: true,
                        STATUS_ID: statusId,
                        REMARK: _remarkController.text)));
                _assetNoFocusNode.requestFocus();
                Navigator.pop(context);
              }, onBack: () {
                Navigator.pop(context);
              });
            }
            if (state.item.MESSAGE ==
                "สินทรัพย์นี้ไม่ได้อยู่ในแผนการตรวจนับ ต้องการเพิ่มเข้าไปในแผนหรือไม่") {
              AlertWarningNew().alertShow(context,
                  type: AlertType.warning,
                  title: "Warning",
                  desc: "${error}", onPress: () {
                BlocProvider.of<CountBloc>(context).add(
                    PostCountSaveNewAssetNewPlanEvent(CountScan_OutputModel(
                        ASSETS_CODE: _assetNoController.text,
                        PLAN_CODE: planCode,
                        LOCATION_ID: locationId,
                        DEPARTMENT_ID: departmentId,
                        IS_SCAN_NOW: true,
                        STATUS_ID: statusId,
                        REMARK: _remarkController.text)));
                _assetNoFocusNode.requestFocus();
                Navigator.pop(context);
              }, onBack: () {
                _barCodeController.clear();
                _assetNoController.clear();
                _nameController.clear();
                _serialNumberController.clear();
                _classController.clear();
                _useDateController.clear();
                _assetNoFocusNode.requestFocus();
                _barcodeFocusNode.requestFocus();
                Navigator.pop(context);
              });
            }
            if (state.item.MESSAGE == "ไม่พบข้อมูลสินทรัพย์ในระบบ!") {
              AlertSnackBar.show(
                  title: '${error}',
                  message: "กรุณาใส่ Barcode ใหม่",
                  type: ReturnStatus.WARNING,
                  crossPage: true);
            }
          } else if (state is CountScanAssetsListErrorState) {
            AlertSnackBar.show(
                title: 'No internet',
                message: "Please Connection Internet",
                type: ReturnStatus.WARNING,
                crossPage: true);
            _assetNoFocusNode.requestFocus();
          }
          if (state is CountScanSaveAssetsLoadedState) {
            if (state.item.STATUS == "SUCCESS") {
              AlertWarningNew().alertShowOK(context,
                  type: AlertType.success,
                  title: "${state.item.STATUS}",
                  desc: "${state.item.MESSAGE}", onPress: () {
                _assetNoController.clear();
                _nameController.clear();
                _serialNumberController.clear();
                _classController.clear();
                _useDateController.clear();
                _barCodeController.clear();
                _barcodeFocusNode.requestFocus();
                Navigator.pop(context);
              });
            } else {
              AlertWarningNew().alertShowOK(context,
                  type: AlertType.success,
                  title: "${state.item.STATUS}",
                  desc: "${state.item.MESSAGE} ", onPress: () {
                _assetNoController.clear();
                _barCodeController.clear();
                _barcodeFocusNode.requestFocus();
                Navigator.pop(context);
              });
            }
          }
          if (state is UploadImageLoadedState) {
            AlertWarningNew().alertShowOK(context,
                title: "${state.item.STATUS}",
                desc: "${state.item.MESSAGE}",
                type: AlertType.success, onPress: () {
              _assetNoController.clear();
              _nameController.clear();
              _serialNumberController.clear();
              _classController.clear();
              _useDateController.clear();
              _barCodeController.clear();
              _barcodeFocusNode.requestFocus();

              Navigator.pop(context);
            });
          } else if (state is UploadImageErrorState) {
            await _uploadPhotoToSqlite();
          }

          if (state is PostCountSaveNewAssetNewPlanLoadedState) {
            EasyLoading.showSuccess("Success");
          }
          setState(() {});
        })
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                  child: Card(
                color: Colors.transparent,
                elevation: 0,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Label("Plan : ${planCode}"),
                ),
              )),
            )
          ],
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
                  child: Form(
                    key: formKeyList[1],
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
                                  value: departmentId != 0 &&
                                          _departmentModel.any((item) =>
                                              item.DEPARTMENT_ID ==
                                              departmentId)
                                      ? _departmentModel
                                          .firstWhere((item) =>
                                              item.DEPARTMENT_ID ==
                                              departmentId)
                                          .DEPARTMENT_NAME
                                      : null,
                                  focusNode: _departmenFocusNode,
                                  validator: (value) {
                                    if (locationId == 0 && departmentId == 0) {
                                      _departmenFocusNode.requestFocus();
                                      return "Please Select Department";
                                    } else {
                                      return null;
                                    }
                                  },
                                  hintText: "Selected Department",
                                  items: _departmentModel.map((item) {
                                    return DropdownMenuItem<dynamic>(
                                      value: item.DEPARTMENT_NAME,
                                      child: Text(
                                        "${item.DEPARTMENT_NAME}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    _departmentController.text = value ?? "-";
                                    departmentId = _departmentModel
                                            .firstWhere((item) =>
                                                item.DEPARTMENT_NAME == value)
                                            .DEPARTMENT_ID ??
                                        0;
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
                                  value: locationId != 0 &&
                                          _locationModel.any((item) =>
                                              item.LOCATION_ID == locationId)
                                      ? _locationModel
                                          .firstWhere((item) =>
                                              item.LOCATION_ID == locationId)
                                          .LOCATION_NAME
                                      : null,
                                  focusNode: _locationFocusNode,
                                  validator: (value) {
                                    if (locationId == 0 && departmentId == 0) {
                                      return "Please Selcetion Location";
                                    } else {
                                      return null;
                                    }
                                  },
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
                                    locationId = _locationModel
                                            .firstWhere((item) =>
                                                item.LOCATION_NAME == value)
                                            .LOCATION_ID ??
                                        0;
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
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: Form(
                    key: formKeyList[0],
                    child: Column(
                      children: [
                        CustomTextInputField(
                          labelText: "BarCode",
                          onChanged: (value) {},
                          focusNode: _barcodeFocusNode,
                          onFieldSubmitted: (value) {
                            if (formKeyList[1].currentState!.validate()) {
                              BlocProvider.of<CountBloc>(context)
                                  .add(PostCountScanAssetListEvent([
                                CountScan_OutputModel(
                                    ASSETS_CODE: _barCodeController.text.trim(),
                                    PLAN_CODE: planCode,
                                    LOCATION_ID: locationId,
                                    DEPARTMENT_ID: departmentId,
                                    IS_SCAN_NOW: true,
                                    REMARK: _remarkController.text.isEmpty
                                        ? "-"
                                        : _remarkController.text.trim(),
                                    STATUS_ID: statusId)
                              ]));
                            }
                          },
                          controller: _barCodeController,
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
                                    _barCodeController.text = res;
                                    BlocProvider.of<CountBloc>(context)
                                        .add(PostCountScanAssetListEvent([
                                      CountScan_OutputModel(
                                          ASSETS_CODE:
                                              _barCodeController.text.trim(),
                                          PLAN_CODE: planCode,
                                          LOCATION_ID: locationId,
                                          DEPARTMENT_ID: departmentId,
                                          IS_SCAN_NOW: true,
                                          REMARK: _remarkController.text.isEmpty
                                              ? "-"
                                              : _remarkController.text.trim(),
                                          STATUS_ID: statusId)
                                    ]));
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
                          value: statusId != 0 &&
                                  _statusAssetCountModel
                                      .any((item) => item.STATUS_ID == statusId)
                              ? _statusAssetCountModel
                                  .firstWhere(
                                      (item) => item.STATUS_ID == statusId)
                                  .STATUS_NAME
                              : null,
                          items: _statusAssetCountModel.map((item) {
                            statusId = 15;
                            return DropdownMenuItem<String>(
                              value: item.STATUS_NAME,
                              child: Text(
                                item.STATUS_NAME ?? "-",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _statusController.text = value ?? "-";
                            statusId = _statusAssetCountModel
                                    .firstWhere(
                                        (item) => item.STATUS_NAME == value)
                                    .STATUS_ID ??
                                0;
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
                                controller: _remarkController,
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
                        SizedBox(
                          height: 5,
                        ),
                        _button()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button() {
    return Row(
      children: [
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 8, left: 8),
            child: CustomButtonPrimary(
              height: 55,
              text: "Save",
              hideLeadingIcon: false,
              leading: LineIcons.save,
              iconColor: Colors.white,
              color: colorActive,
              onPress: () async {
                await _buttonSave();
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 8, left: 8),
            child: CustomButtonPrimary(
              height: 55,
              text: "Camera",
              hideLeadingIcon: false,
              leading: LineIcons.camera,
              iconColor: Colors.white,
              color: colorWarning,
              onPress: () {
                if (_barCodeController.text.isNotEmpty) {
                  if (formKeyList[1].currentState!.validate()) {
                    _uploadPhotoToServer();
                  }
                } else {
                  AlertWarningNew().alertShowOK(context,
                      type: AlertType.warning,
                      desc: " Please Input Barcode", onPress: () {
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
