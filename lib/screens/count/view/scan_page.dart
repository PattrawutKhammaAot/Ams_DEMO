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

import '../../../models/count/tempCountScanAsset/tempcountScanAssetOuput.dart';
import '../../../models/report/listCountDetail_report_model.dart';
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
  int statusId = 15;
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
  String statsCheck = "";
  String? typePage;
  TextEditingController statusCheckFormReprot = TextEditingController();

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

  Future _buttonSaveFunc({String? type}) async {
    if (_departmentController.text.isNotEmpty ||
        _locationController.text.isNotEmpty) {
      if (await AppData.getMode() == "Offline") {
        printInfo(info: "offline");
        if (typePage == "reportPage") {
          String statusName = _statusAssetCountModel
                  .firstWhere((element) => element.STATUS_ID == statusId)
                  .STATUS_NAME ??
              "ปกติ";
          await ListCountDetailReportModel().updateForRemarkAndStatusCheck(
              assetCode: _barCodeController.text,
              planCode: planCode,
              remark: _remarkController.text,
              statusId: statusName);
          await _setValueUpdateTableCountScanOutputModelForButtonSaved();
        } else {
          var itemSql = await ListCountDetailReportModel()
              .querySelectColumn(assetCode: _assetNoController.text);
          List<ListCountDetailReportModel> itemModel = [];

          if (itemSql.isNotEmpty) {
            itemModel = itemSql
                .map((e) => ListCountDetailReportModel.fromJson(e))
                .toList();

            setState(() {});
          }

          printInfo(info: "Sql ${itemSql.length}");
          printInfo(info: "${itemModel.length}");
          var itemId =
              itemModel.where((element) => element.PLAN_CODE == planCode).first;

          _setUpdateTableListCountPlanField(itemId);
        }

        await CountScan_OutputModel()
            .updateForAssetAndPlan(
          assetCode: _assetNoController.text,
          planCode: planCode!,
          remark: _remarkController.text,
          locationid: locationId,
          departmentid: departmentId,
          statusId: statusId,
        )
            .then((value) {
          if (typePage != "reportPage") {
            _barcodeFocusNode.requestFocus();
            // _assetNoController.clear();
            // _nameController.clear();
            // _serialNumberController.clear();
            // _classController.clear();
            // _useDateController.clear();
            _barCodeController.clear();
            // _remarkController.clear();
            // _barcodeFocusNode.requestFocus();

            statusId = 15;
          }
        });

        AlertWarningNew().alertShowOK(context,
            title: "Save Success",
            desc: "",
            type: AlertType.success, onPress: () {
          Navigator.pop(context);
        });
      } else {
        String _statusId = '';
        _statusId = _statusAssetCountModel
                .firstWhere((element) => element.STATUS_ID == statusId)
                .STATUS_NAME ??
            "ปกติ";
        BlocProvider.of<CountBloc>(context).add(PostCountScanSaveAssetEvent(
            TempCountScan_OutputModel(
                ASSETS_CODE: _assetNoController.text.trim(),
                PLAN_CODE: planCode,
                LOCATION_ID: locationId,
                DEPARTMENT_ID: departmentId,
                IS_SCAN_NOW: true,
                REMARK: _remarkController.text,
                STATUS_ID: statusId,
                CHECK_DATE: DateTime.now().toIso8601String())));

        await ListCountDetailReportModel().updateAll(
            assetCode: _assetNoController.text,
            planCode: planCode,
            statusId: _statusId,
            remark: _remarkController.text,
            statusCheck: "Checked");
        // _assetNoController.clear();
        // _nameController.clear();
        // _serialNumberController.clear();
        // _classController.clear();
        // _useDateController.clear();
        // _barCodeController.clear();
        // _remarkController.clear();
        // _barcodeFocusNode.requestFocus();

        statusId = 15;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    BlocProvider.of<CountBloc>(context).add(const GetLocationEvent());
    BlocProvider.of<CountBloc>(context).add(const GetDepartmentEvent());
    BlocProvider.of<CountBloc>(context).add(const GetStatusAssetsCountEvent());
    if (typePage == "reportPage") {
      _statusFocusNode.requestFocus();
    } else {
      _departmenFocusNode.requestFocus();
    }
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
              ASSETS_CODE: _assetNoController.text.toUpperCase(),
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
          ASSETS_CODE: _assetNoController.text, URL_IMAGE: newImage.path));
      AlertWarningNew().alertShowOK(context,
          title: "Save Success",
          desc: "Internet Offline Save Image to Local",
          type: AlertType.success, onPress: () {
        Navigator.pop(context);
      });
    }
  }

  _initialFromReportScreen() async {
    planCode = arguments?['planCode'] ?? "Please Select Plan";
    typePage = arguments?['typePage'] ?? "-";
    if (arguments?['typePage'] == "reportPage") {
      setState(() {
        scanDate.text =
            arguments?['scanDate'] == "" ? "-" : arguments?['scanDate'];
        statusCheckFormReprot.text = arguments?['statusCheck'] ?? "-";
        locationId = arguments?['locationID'] ?? 0;
        departmentId = arguments?['departmentID'] ?? 0;
        _barCodeController.text =
            arguments?['assetsCode'] ?? _barCodeController.text;
        _assetNoController.text =
            arguments?['assetsCode'] ?? _assetNoController.text;
        _nameController.text = arguments?['name'] ?? _nameController.text;
        _remarkController.text = arguments?['remark'] ?? _remarkController.text;
        _serialNumberController.text =
            arguments?['snNo'] == "" ? "-" : arguments?['snNo'];

        _classController.text = arguments?['class'] ?? _classController.text;
        _useDateController.text =
            arguments?['use.date'] ?? _useDateController.text;
      });
      if (arguments?['statusName'] != "-") {
        statusId = _statusAssetCountModel
                .firstWhere((element) =>
                    element.STATUS_NAME == arguments?['statusName'])
                .STATUS_ID ??
            15;
      } else {
        statusId = 15;
      }
    } else {
      scanDate.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
    }

    _departmentController.text = departmentId.toString();
    _locationController.text = locationId.toString();
    _statusController.text = statusId.toString();
    setState(() {});
  }

  _setvalueCountScanWhenCallApiError() async {
    var itemSql = await ListCountDetailReportModel()
        .querySelectColumn(assetCode: _barCodeController.text);
    List<ListCountDetailReportModel> itemModel = [];

    if (itemSql.isNotEmpty) {
      itemModel =
          itemSql.map((e) => ListCountDetailReportModel.fromJson(e)).toList();

      setState(() {});
    }

    if (itemSql.length == 0 && itemSql != null) {
      AlertWarningNew().alertShowOK(context,
          type: AlertType.warning, title: "ไม่พบข้อมูลสินทรัพย์", onPress: () {
        Navigator.pop(context);
        _barCodeController.clear();
        _barcodeFocusNode.requestFocus();
      });
    } else if (!itemModel.any((element) => element.PLAN_CODE == planCode)) {
      AlertWarningNew().alertShow(context,
          type: AlertType.warning,
          title:
              "สินทรัพย์นี้ไม่ได้อยู่ในแผนการตรวจนับ ต้องการเพิ่มเข้าไปในแผนหรือไม่",
          onPress: () async {
        var item = itemModel
            .where((element) => element.ASSET_CODE == _barCodeController.text)
            .first;

        _remarkController.text = item.REMARK ?? "-";
        _assetNoController.text = item.ASSET_CODE ?? "-";
        _nameController.text = item.ASSET_NAME ?? "-";
        scanDate.text = item.CHECK_DATE ?? "-";
        _classController.text = item.CLASS_NAME ?? "-";
        _serialNumberController.text = item.ASSET_SERIAL_NO ?? "-";
        _useDateController.text = item.ASSET_DATE_OF_USE ?? "-";
        if (item.STATUS_NAME != null) {
          statusId = _statusAssetCountModel
                  .firstWhere(
                      (element) => element.STATUS_NAME == item.STATUS_NAME)
                  .STATUS_ID ??
              15;
        } else {
          statusId = 15;
          setState(() {});
        }
        String? locationName = _locationModel
            .firstWhere((element) => element.LOCATION_ID == locationId,
                orElse: () => LocationModel(
                    LOCATION_NAME: "-")) // ใส่ค่าเริ่มต้น "0" เมื่อไม่พบข้อมูล
            .LOCATION_NAME;

        String? departmentName = _departmentModel
            .firstWhere((element) => element.DEPARTMENT_ID == departmentId,
                orElse: () => DepartmentModel(
                    DEPARTMENT_NAME:
                        "-")) // ใส่ค่าเริ่มต้น "-" เมื่อไม่พบข้อมูล
            .DEPARTMENT_NAME;
        await ListCountDetailReportModel().insertNot({
          'planCode': planCode,
          'assetCode': item.ASSET_CODE,
          'assetName': item.ASSET_NAME,
          'beforeLocationId': locationId,
          'beforeLocationName': locationName,
          'beforeDepartmentId': departmentId,
          'beforeDepartmentName': departmentName,
          'checkDate': DateTime.now().toIso8601String(),
          'statusCheck': "Checked",
          'statusName': item.STATUS_NAME,
          'remark': item.REMARK,
          ListCountDetailReportField.ASSET_SERIAL_NO: item.ASSET_SERIAL_NO,
          ListCountDetailReportField.CLASS_NAME: item.CLASS_NAME,
          ListCountDetailReportField.ASSET_DATE_OF_USE: item.ASSET_DATE_OF_USE,
          'qty': item.QTY ?? 1,
        });
        setState(() {});

        await _setValueTableCountScanOutputForScanBarcode(status: "notPlan");
        _barCodeController.clear();
        Navigator.pop(context);
      }, onBack: () {
        Navigator.pop(context);
      });
    } else {
      var itemId =
          itemModel.where((element) => element.PLAN_CODE == planCode).first;

      //select Location only
      if (departmentId == 0 && locationId != 0) {
        if (locationId == itemId.BEFORE_LOCATION_ID) {
          _checkStatus(itemId, onPress: () async {
            await _setValueTableCountScanOutputForScanBarcode();
          });
        } else {
          AlertSnackBar.show(
              title: 'Warning',
              message: "ตรวจพบ สินทรัพย์สถานที่ไม่ตรงกับระบบ",
              type: ReturnStatus.WARNING,
              crossPage: true);
          _checkStatus(itemId, onPress: () async {
            await _setValueTableCountScanOutputForScanBarcode();
          });
        }
      } // select Department Only
      else if (departmentId != 0 && locationId == 0) {
        if (departmentId == itemId.BEFORE_DEPARTMENT_ID) {
          _checkStatus(itemId, onPress: () async {
            await _setValueTableCountScanOutputForScanBarcode();
          });
        } else {
          AlertSnackBar.show(
              title: 'Warning',
              message: "ตรวจพบ สินทรัพย์แผนกไม่ตรงกับระบบ",
              type: ReturnStatus.WARNING,
              crossPage: true);
          _checkStatus(itemId, onPress: () async {
            await _setValueTableCountScanOutputForScanBarcode();
          });
        }
      }
      //select Both
      else {
        if (departmentId == itemId.BEFORE_DEPARTMENT_ID &&
            locationId == itemId.BEFORE_LOCATION_ID) {
          _checkStatus(itemId, onPress: () async {
            await _setValueTableCountScanOutputForScanBarcode();
          });
        } else {
          AlertSnackBar.show(
              title: 'Warning',
              message: "ตรวจพบ สินทรัพย์สถานที่ และโลเคชั่น ไม่ตรงกับระบบ",
              type: ReturnStatus.WARNING,
              crossPage: true);
          _checkStatus(itemId, onPress: () async {
            await _setValueTableCountScanOutputForScanBarcode();
          });
        }
      }
    }

    _barcodeFocusNode.requestFocus();

    setState(() {});
  }

  _setUpdateTableListCountPlanField(ListCountDetailReportModel item) async {
    String statusName = _statusAssetCountModel
            .firstWhere((element) => element.STATUS_ID == statusId)
            .STATUS_NAME ??
        "ปกติ";

    if (item.STATUS_CHECK == "Unchecked") {
      await ListCountDetailReportModel().updateForAssetAndPlan(
          assetCode: _barCodeController.text,
          planCode: planCode,
          remark: _remarkController.text.isEmpty
              ? item.REMARK
              : _remarkController.text,
          departmentid: _departmentController.text.isEmpty
              ? item.BEFORE_DEPARTMENT_ID
              : departmentId,
          locationid: _locationController.text.isEmpty
              ? item.BEFORE_DEPARTMENT_ID
              : locationId,
          statusId: statusName,
          statusCheck: "Checked",
          locationName: _locationController.text.isEmpty
              ? item.BEFORE_LOCATION_NAME
              : _locationController.text,
          departmentName: _departmentController.text.isEmpty
              ? item.BEFORE_DEPARTMENT_NAME
              : _departmentController.text,
          serialNo: _serialNumberController.text,
          classname: _classController.text,
          useDate: _useDateController.text,
          checkDate: DateFormat("yyyy-MM-dd").format(DateTime.now()));
    } else {
      await ListCountDetailReportModel().updateForAssetAndPlan(
          assetCode: _barCodeController.text,
          planCode: planCode,
          remark: _remarkController.text,
          locationid: locationId,
          statusId: statusName,
          departmentid: _departmentController.text.isEmpty
              ? item.BEFORE_DEPARTMENT_ID
              : departmentId,
          locationName: _locationController.text.isEmpty
              ? item.BEFORE_LOCATION_NAME
              : _locationController.text,
          departmentName: _departmentController.text.isEmpty
              ? item.BEFORE_DEPARTMENT_NAME
              : _departmentController.text,
          statusCheck: "Checked",
          serialNo: _serialNumberController.text,
          classname: _classController.text,
          useDate: _useDateController.text,
          checkDate: item.CHECK_DATE);
    }
  }

  _setValueUpdateTableCountScanOutputModelForButtonSaved() async {
    var item = await CountScan_OutputModel().queryAllRows();
    bool foundMatch =
        false; // เพิ่มตัวแปรนี้เพื่อตรวจสอบว่าพบข้อมูลที่ตรงกับเงื่อนไขหรือไม่
    var itemList = await ListCountDetailReportModel()
        .queryPlanAndAsset(plan: planCode, asset: _barCodeController.text);
    for (var items in item) {
      if (items[CountScanOutputField.ASSETS_CODE] == _barCodeController.text &&
          items[CountScanOutputField.PLAN_CODE] == planCode) {
        foundMatch = true; // ตั้งค่าเป็น true เมื่อพบข้อมูลที่ตรงกับเงื่อนไข
        break; // หยุดลูปเมื่อพบข้อมูลที่ตรงกับเงื่อนไข
      }
    }
    String? _statusChecked;

    for (var items in itemList) {
      if (items[ListCountDetailReportField.STATUS_CHECK] == "Checked") {
        _statusChecked = "AlreadyChecked";
        printInfo(info: "_statusChecked");
      } else {
        _statusChecked = "Checked";
        printInfo(info: "Checked");
      }
    }
    setState(() {});

    printInfo(info: "${_statusChecked}");
    if (!foundMatch) {
      // ถ้าไม่พบข้อมูลที่ตรงกับเงื่อนไข ให้ทำการเพิ่มข้อมูล
      await CountScan_OutputModel()
          .insert(CountScan_OutputModel(
        ASSETS_CODE: _barCodeController.text,
        PLAN_CODE: planCode,
        LOCATION_ID: locationId,
        DEPARTMENT_ID: departmentId,
        STATUS_ID: statusId,
        IS_SCAN_NOW: true,
        REMARK: _remarkController.text,
        STATUS_REQUEST: _statusChecked,
        CHECK_DATE: DateTime.now().toIso8601String(),
      ))
          .then((value) {
        setState(() {
          _barCodeController.clear();
        });
      });
    } else {
      await CountScan_OutputModel().update(
          {"remark": _remarkController.text, "statusId": statusId},
          [_barCodeController.text, planCode]);
    }
  }

  _setValueTableCountScanOutputForScanBarcode({String? status}) async {
    var item = await CountScan_OutputModel().queryAllRows();
    bool foundMatch =
        false; // เพิ่มตัวแปรนี้เพื่อตรวจสอบว่าพบข้อมูลที่ตรงกับเงื่อนไขหรือไม่
    printInfo(info: "${item}");
    for (var items in item) {
      if (items[CountScanOutputField.ASSETS_CODE] == _barCodeController.text &&
          items[CountScanOutputField.PLAN_CODE] == planCode) {
        foundMatch = true; // ตั้งค่าเป็น true เมื่อพบข้อมูลที่ตรงกับเงื่อนไข
        break; // หยุดลูปเมื่อพบข้อมูลที่ตรงกับเงื่อนไข
      }
    }

    if (!foundMatch) {
      // ถ้าไม่พบข้อมูลที่ตรงกับเงื่อนไข ให้ทำการเพิ่มข้อมูล
      await CountScan_OutputModel()
          .insert(CountScan_OutputModel(
        ASSETS_CODE: _barCodeController.text,
        PLAN_CODE: planCode,
        LOCATION_ID: locationId,
        DEPARTMENT_ID: departmentId,
        STATUS_ID: statusId,
        IS_SCAN_NOW: true,
        REMARK: _remarkController.text,
        STATUS_REQUEST: status ?? statsCheck,
        CHECK_DATE: DateTime.now().toIso8601String(),
      ))
          .then((value) {
        setState(() {
          _barCodeController.clear();
        });
      });
    } else {
      printInfo(info: "Founded");

      await CountScan_OutputModel().update({
        'assetCode': _barCodeController.text,
        'planCode': planCode,
        'locationId': locationId,
        'departmentId': departmentId,
        'isScanNow': true,
        'remark': _remarkController.text,
        'statusId': statusId,
        'statusRequest': status ?? statsCheck,
      }, [
        _barCodeController.text,
        planCode
      ]).then((value) {
        setState(() {
          _barCodeController.clear();
        });
      });
    }

    printInfo(info: "${item}");
  }

  _checkStatus(ListCountDetailReportModel itemModel,
      {dynamic Function()? onPress}) async {
    printInfo(info: "${itemModel.ASSET_SERIAL_NO}");
    if (itemModel.STATUS_CHECK == "Checked") {
      AlertWarningNew().alertShow(context,
          type: AlertType.warning,
          title: "สินทรัพย์นี้ได้ถูกตรวจนับแล้ว ต้องการตรวจเช็คซ้ำหรือไม่",
          onPress: () async {
        _remarkController.text = itemModel.REMARK ?? "-";
        _assetNoController.text = itemModel.ASSET_CODE ?? "-";
        _nameController.text = itemModel.ASSET_NAME ?? "-";
        _classController.text = itemModel.CLASS_NAME ?? "-";
        _serialNumberController.text = itemModel.ASSET_SERIAL_NO ?? "-";
        _useDateController.text = itemModel.ASSET_DATE_OF_USE ?? "-";

        if (itemModel.STATUS_NAME != null) {
          statusId = _statusAssetCountModel
                  .firstWhere((element) => element.STATUS_NAME == "ปกติ")
                  .STATUS_ID ??
              15;
        } else {
          statusId = _statusAssetCountModel
                  .firstWhere((element) => element.STATUS_NAME == "ปกติ")
                  .STATUS_ID ??
              15;
        }
        await _setUpdateTableListCountPlanField(itemModel);
        statsCheck = "AlreadyChecked";
        setState(() {});
        onPress?.call().then((element) {
          setState(() {
            _barCodeController.clear();
          });
        });

        _barcodeFocusNode.requestFocus();
        Navigator.pop(context);
      }, onBack: () {
        Navigator.pop(context);
      });
    } else {
      _remarkController.text = itemModel.REMARK ?? "-";
      _assetNoController.text = itemModel.ASSET_CODE ?? "-";
      _nameController.text = itemModel.ASSET_NAME ?? "-";
      _classController.text = itemModel.CLASS_NAME ?? "-";
      _serialNumberController.text = itemModel.ASSET_SERIAL_NO ?? "-";
      _useDateController.text = itemModel.ASSET_DATE_OF_USE ?? "-";

      if (itemModel.STATUS_NAME != null) {
        statusId = _statusAssetCountModel
                .firstWhere((element) => element.STATUS_NAME == "ปกติ")
                .STATUS_ID ??
            15;
      } else {
        statusId = 15;

        setState(() {});
      }
      statsCheck = "Checked";
      await _setUpdateTableListCountPlanField(itemModel);
      await _setValueTableCountScanOutputForScanBarcode();
      setState(() {
        _barCodeController.clear();
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // scanDate.text = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    return MultiBlocListener(
      listeners: [
        BlocListener<CountBloc, CountState>(listener: (context, state) async {
          if (state is GetLocationLoadedState) {
            _locationModel = state.item;

            await DbSqlite()
                .deleteAll(tableName: '${LocationField.TABLE_NAME}');
            for (var item in state.item) {
              await LocationModel().insert(item.toJson());
            }
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

            _initialFromReportScreen();
          } else if (state is GetStatusAssetErrorState) {
            var itemSql = await StatusAssetCountModel().query();
            _statusAssetCountModel = itemSql
                .map((map) => StatusAssetCountModel.fromJson(map))
                .toList();

            setState(() {});
            _initialFromReportScreen();
          }

          if (state is CountScanAssetsListLoadedState) {
            var data = state.item.DATA;

            if (data != null) {
              itemCountListModel = CountScanAssetsModel.fromJson(data);

              if (state.item.STATUS == "WARNING") {
                AlertSnackBar.show(
                    title: 'Warning',
                    message: "${state.item.MESSAGE}",
                    type: ReturnStatus.WARNING,
                    crossPage: true);

                error = state.item.MESSAGE;
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

                statusId = _statusAssetCountModel
                        .firstWhere((element) =>
                            element.STATUS_NAME ==
                            itemCountListModel.STATUS_NAME)
                        .STATUS_ID ??
                    15;

                DateTime? parsedDate =
                    DateTime.tryParse(_useDateController.text);
                String formattedDate = parsedDate != null
                    ? DateFormat("yyyy-MM-dd").format(parsedDate)
                    : "-";
                _useDateController.text = formattedDate;

                printInfo(info: "อัพเดทข้อมูลสำเร็จ State Warning");
                printInfo(info: "${statusId}");
              } else if (state.item.MESSAGE == "อัพเดทข้อมูลสำเร็จ") {
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
                statusId = _statusAssetCountModel
                        .firstWhere((element) =>
                            element.STATUS_NAME ==
                            itemCountListModel.STATUS_NAME)
                        .STATUS_ID ??
                    15;

                DateTime? parsedDate =
                    DateTime.tryParse(_useDateController.text);
                String formattedDate = parsedDate != null
                    ? DateFormat("yyyy-MM-dd").format(parsedDate)
                    : "-";
                _useDateController.text = formattedDate;

                setState(() {});
              }
              _barCodeController.clear();
              _barcodeFocusNode.requestFocus();
            } else if (data == null &&
                state.item.MESSAGE ==
                    'สินทรัพย์นี้ได้ถูกตรวจนับแล้ว ต้องการตรวจเช็คซ้ำหรือไม่') {
              AlertWarningNew().alertShow(context,
                  type: AlertType.warning,
                  title: "Warning",
                  desc: "${state.item.MESSAGE}", onPress: () {
                BlocProvider.of<CountBloc>(context).add(
                    PostCountScanAlreadyCheckEvent(TempCountScan_OutputModel(
                        ASSETS_CODE: _barCodeController.text.trim(),
                        PLAN_CODE: planCode,
                        LOCATION_ID: locationId,
                        DEPARTMENT_ID: departmentId,
                        IS_SCAN_NOW: true,
                        STATUS_ID: statusId,
                        REMARK: _remarkController.text,
                        CHECK_DATE: DateTime.now().toIso8601String())));
                _barCodeController.clear();
                _barcodeFocusNode.requestFocus();
                Navigator.pop(context);
              }, onBack: () {
                Navigator.pop(context);
              });
            } else if (state.item.MESSAGE ==
                    "สินทรัพย์นี้ไม่ได้อยู่ในแผนการตรวจนับ ต้องการเพิ่มเข้าไปในแผนหรือไม่" &&
                data == null) {
              setState(() {});
              AlertWarningNew().alertShow(context,
                  type: AlertType.warning,
                  title: "Warning",
                  desc:
                      "สินทรัพย์นี้ไม่ได้อยู่ในแผนการตรวจนับ ต้องการเพิ่มเข้าไปในแผนหรือไม่",
                  onPress: () {
                BlocProvider.of<CountBloc>(context).add(
                    PostCountSaveNewAssetNewPlanEvent(TempCountScan_OutputModel(
                        ASSETS_CODE: _barCodeController.text.trim(),
                        PLAN_CODE: planCode,
                        LOCATION_ID: locationId,
                        DEPARTMENT_ID: departmentId,
                        IS_SCAN_NOW: true,
                        STATUS_ID: statusId,
                        REMARK: _remarkController.text,
                        CHECK_DATE: DateTime.now().toIso8601String())));
                _barCodeController.clear();
                _barcodeFocusNode.requestFocus();
                Navigator.pop(context);
              }, onBack: () {
                Navigator.pop(context);
              });
            } else if (state.item.MESSAGE == "ไม่พบข้อมูลสินทรัพย์ในระบบ!" &&
                data == null) {
              AlertSnackBar.show(
                  title: 'Warning',
                  message: "${state.item.MESSAGE}",
                  type: ReturnStatus.WARNING,
                  crossPage: true);
              _barCodeController.clear();
              _barcodeFocusNode.requestFocus();
            }
            // _barCodeController.clear();
            // _barcodeFocusNode.requestFocus();
          } else if (state is CountScanAssetsListErrorState) {
            await _setvalueCountScanWhenCallApiError();
          }
          if (state is CountScanSaveAssetsLoadedState) {
            if (state.item.STATUS == "SUCCESS") {
              AlertWarningNew().alertShowOK(context,
                  type: AlertType.success,
                  title: "${state.item.STATUS}",
                  desc: "${state.item.MESSAGE}", onPress: () {
                // _assetNoController.clear();
                // _nameController.clear();
                // _serialNumberController.clear();
                // _classController.clear();
                // _useDateController.clear();
                // _barCodeController.clear();
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

          if (state is PostCountScanAlreadyCheckLoadedState) {
            if (state.item.ASSET_CODE != null) {
              printInfo(info: "NullChecked");

              _serialNumberController.text = state.item.ASSET_SERIALNO ?? "-";
              _nameController.text = state.item.ASSETNAME ?? "-";
              _classController.text = state.item.CLASSNAME ?? "-";
              _remarkController.text = state.item.REMARK ?? "-";
              _assetNoController.text = state.item.ASSET_CODE ?? "-";

              _serialNumberController.text = state.item.ASSET_SERIALNO ?? "";
              _useDateController.text = state.item.ASSET_DATEOFUSE ?? "-";
              if (state.item.STATUS_NAME != null) {
                statusId = _statusAssetCountModel
                        .firstWhere((element) =>
                            element.STATUS_NAME == state.item.STATUS_NAME)
                        .STATUS_ID ??
                    15;
              } else {
                statusId = 15;
              }
            }

            setState(() {});
          }
        })
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back(
                    result: {"GetBack": "getback", "GetToCount": "getCount"});
              },
              icon: Icon(
                Icons.arrow_back,
              )),
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
                  child: GestureDetector(
                      onDoubleTap: () async {
                        Get.toNamed('/ViewDatabase');
                      },
                      child: Label("Plan : ${planCode}")),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: CustomDropdownButton2(
                                  readOnly:
                                      statusCheckFormReprot.text == "Checked" &&
                                              typePage == "reportPage"
                                          ? true
                                          : false,
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
                                      return null;
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
                                  onChanged:
                                      statusCheckFormReprot.text == "Checked" &&
                                              typePage == "reportPage"
                                          ? null
                                          : (value) {
                                              _departmentController.text =
                                                  value ?? "-";
                                              departmentId = _departmentModel
                                                      .firstWhere((item) =>
                                                          item.DEPARTMENT_NAME ==
                                                          value)
                                                      .DEPARTMENT_ID ??
                                                  0;

                                              _barcodeFocusNode.requestFocus();
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
                              padding: const EdgeInsets.all(8.0),
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
                                      return null;
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
                                  onChanged:
                                      statusCheckFormReprot.text == "Checked" &&
                                              typePage == "reportPage"
                                          ? null
                                          : (value) {
                                              setState(() {});
                                              _locationController.text =
                                                  value ?? "-";
                                              locationId = _locationModel
                                                      .firstWhere((item) =>
                                                          item.LOCATION_NAME ==
                                                          value)
                                                      .LOCATION_ID ??
                                                  0;

                                              _barcodeFocusNode.requestFocus();
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
                          readOnly: typePage == "reportPage" ? true : false,
                          labelText: "Barcode",
                          onChanged: (value) {},
                          focusNode: _barcodeFocusNode,
                          onFieldSubmitted: (value) {
                            if (formKeyList[1].currentState!.validate()) {
                              if (departmentId != 0 || locationId != 0) {
                                BlocProvider.of<CountBloc>(context)
                                    .add(PostCountScanAssetListEvent([
                                  TempCountScan_OutputModel(
                                      ASSETS_CODE:
                                          _barCodeController.text.trim(),
                                      PLAN_CODE: planCode,
                                      LOCATION_ID: locationId,
                                      DEPARTMENT_ID: departmentId,
                                      IS_SCAN_NOW: true,
                                      REMARK: _remarkController.text.isEmpty
                                          ? "-"
                                          : _remarkController.text.trim(),
                                      STATUS_ID: statusId,
                                      CHECK_DATE:
                                          DateTime.now().toIso8601String())
                                ]));
                              } else {
                                AlertWarningNew().alertShowOK(context,
                                    title: "Warning",
                                    type: AlertType.warning,
                                    desc: "กรุณาเลือกข้อมูลก่อนตรวจนับ",
                                    onPress: () => Navigator.pop(context));
                              }
                            } else {
                              AlertWarningNew().alertShowOK(context,
                                  title: "Warning",
                                  type: AlertType.warning,
                                  desc: "กรุณาเลือกข้อมูลก่อนตรวจนับ",
                                  onPress: () => Navigator.pop(context));
                            }
                          },
                          controller: _barCodeController,
                          isHideLable: true,
                          validator: (value) =>
                              _validate(value!, _barcodeFocusNode),
                          suffixIcon: IconButton(
                              onPressed: () async {
                                if (departmentId != 0 || locationId != 0) {
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
                                        TempCountScan_OutputModel(
                                            ASSETS_CODE:
                                                _barCodeController.text.trim(),
                                            PLAN_CODE: planCode,
                                            LOCATION_ID: locationId,
                                            DEPARTMENT_ID: departmentId,
                                            IS_SCAN_NOW: true,
                                            REMARK: _remarkController
                                                    .text.isEmpty
                                                ? "-"
                                                : _remarkController.text.trim(),
                                            STATUS_ID: statusId,
                                            CHECK_DATE: DateTime.now()
                                                .toIso8601String())
                                      ]));
                                      _barcodeFocusNode.requestFocus();
                                    }
                                  });
                                } else {
                                  AlertSnackBar.show(
                                      title: 'Warning',
                                      message:
                                          "กรุณา เลือกสถานที่ หรือ แผนก ของสินทรัพย์ก่อนแสกน",
                                      type: ReturnStatus.WARNING,
                                      crossPage: true);
                                }
                              },
                              icon: Icon(Icons.qr_code)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextInputField(
                          readOnly: typePage == "reportPage"
                              ? true
                              : false || _assetNoController.text.isNotEmpty
                                  ? true
                                  : false,
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
                          readOnly: typePage == "reportPage"
                              ? true
                              : false || _assetNoController.text.isNotEmpty
                                  ? true
                                  : false,
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
                          readOnly: typePage == "reportPage"
                              ? true
                              : false || _assetNoController.text.isNotEmpty
                                  ? true
                                  : false,
                          isHideLable: true,
                          onFieldSubmitted: (value) =>
                              _validate(value, _classFocusNode),
                          labelText: "Serial Number",
                          focusNode: _serialNumberFocusNode,
                          controller: _serialNumberController,
                          // validator: (value) =>
                          //     _validate(value!, _serialNumberFocusNode),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextInputField(
                          readOnly: typePage == "reportPage"
                              ? true
                              : false || _assetNoController.text.isNotEmpty
                                  ? true
                                  : false,
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
                          readOnly: typePage == "reportPage"
                              ? true
                              : false || _assetNoController.text.isNotEmpty
                                  ? true
                                  : false,
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
                        _buttonWidget()
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

  Widget _buttonWidget() {
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
              onPress: () async => await _buttonSaveFunc(),
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
                if (_assetNoController.text.isNotEmpty) {
                  _uploadPhotoToServer();
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
