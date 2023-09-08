import 'package:ams_count/blocs/asset/assets_bloc.dart';
import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/config/app_data.dart';
import 'package:ams_count/models/assets/getDetailAssetModel.dart';
import 'package:ams_count/widgets/alert.dart';
import 'package:ams_count/widgets/custom_textfield.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../data/models/api_response.dart';

class MyAssetsPage extends StatefulWidget {
  const MyAssetsPage({super.key});

  @override
  State<MyAssetsPage> createState() => _MyAssetsPageState();
}

class _MyAssetsPageState extends State<MyAssetsPage> {
  String textTitle = 'Asset Detail';
  TextEditingController _barCode = TextEditingController();
  TextEditingController _assetNo = TextEditingController();
  TextEditingController _assetName = TextEditingController();
  TextEditingController _usedDate = TextEditingController();
  TextEditingController _lifeYear = TextEditingController();
  TextEditingController _assetStatus = TextEditingController();
  TextEditingController _company = TextEditingController();
  TextEditingController _branchName = TextEditingController();
  TextEditingController _building = TextEditingController();
  TextEditingController _room = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _department = TextEditingController();
  TextEditingController _owner = TextEditingController();
  FocusNode _focusBarCode = FocusNode();

  GetDetailAssetModel _detailAssetModel = GetDetailAssetModel();

  _setValueController(GetDetailAssetModel itemModel) {
    String? _convertDate = DateFormat('yyyy-MM-dd').format(
        DateTime.tryParse(itemModel.ASSET_DATE_OF_USE ?? "-") ??
            DateTime.now());

    _assetNo.text = itemModel.ASSET_CODE ?? "-";
    _assetName.text = itemModel.ASSET_NAME ?? "-";
    _usedDate.text = itemModel.ASSET_DATE_OF_USE != null ? _convertDate : "-";
    _lifeYear.text =
        itemModel.LIFE_YEAR != null ? itemModel.LIFE_YEAR.toString() : "-";
    _assetStatus.text = itemModel.STATUS_NAME ?? "-";
    _company.text = itemModel.COMPANY_NAME ?? "-";
    _branchName.text = itemModel.BRANCH_NAME ?? "-";
    _building.text = itemModel.BUILDING_NAME ?? "-";
    _room.text = itemModel.ROOM_NAME ?? "-";
    _location.text = itemModel.LOCATION_NAME ?? "-";
    _department.text = itemModel.DEPARTMENT_NAME ?? "-";
    _owner.text = itemModel.OWNER_NAME ?? "-";
  }

  _scanBarcode() async {
    var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(),
        ));
    setState(() {
      if (res is String) {
        _barCode.text = res;
        if (_barCode.text != "-1" && _barCode.text.isNotEmpty) {
          BlocProvider.of<AssetsBloc>(context)
              .add(GetDetailAssetEvent(_barCode.text));
        } else {
          AlertSnackBar.show(
              title: 'Barcode Invalid',
              message: 'Please ScanBarcode Again',
              type: ReturnStatus.WARNING,
              crossPage: true);
        }
      }
    });
  }

  @override
  void initState() {
    _focusBarCode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AssetsBloc, AssetsState>(listener: (context, state) async {
          if (state is GetDetailAssetLoadedState) {
            _detailAssetModel = state.item;
            _setValueController(_detailAssetModel);
            AlertSnackBar.show(
                title: 'SUCCESS',
                message: "Get Data Success",
                type: ReturnStatus.SUCCESS,
                crossPage: true);

            setState(() {});
          } else if (state is GetDetailAssetErrorState) {
            if (await AppData.getMode() == 'Offline') {
              AlertSnackBar.show(
                  title: 'No Internet',
                  message: 'Please Connection Internet',
                  type: ReturnStatus.WARNING,
                  crossPage: true);
            } else {
              AlertSnackBar.show(
                  title: 'AssetNo invaild',
                  message: 'Please try Again',
                  type: ReturnStatus.WARNING,
                  crossPage: true);
              _barCode.clear();
              _focusBarCode.requestFocus();
            }
          }
        })
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Label("My Assets"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: _detailAssetModel.ASSET_NAME != null
                    ? Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: _detailAssetModel.IMG1 != null
                                  ? Image.network(
                                      "${_detailAssetModel.IMG1}",
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      'assets/images/nopictureAvaliable.png',
                                    ),
                            );
                          } else if (index == 1) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: _detailAssetModel.IMG2 != null
                                  ? Image.network(
                                      "${_detailAssetModel.IMG2}",
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      'assets/images/nopictureAvaliable.png',
                                    ),
                            );
                          } else if (index == 2) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: _detailAssetModel.IMG3 != null
                                  ? Image.network(
                                      "${_detailAssetModel.IMG3}",
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      'assets/images/nopictureAvaliable.png',
                                    ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                        itemCount: 3,
                        pagination: SwiperPagination(),
                        control: SwiperControl(color: colorPrimary),
                      )
                    : Image.asset(
                        'assets/images/nopictureAvaliable.png',
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              _divider(),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 0.1,
                      color: Colors.white,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Swiper(
                                physics: BouncingScrollPhysics(),
                                onIndexChanged: (value) {
                                  print(value);
                                  if (value == 1) {
                                    textTitle = 'Asset Tracking';
                                  } else if (value == 0) {
                                    textTitle = 'Asset Detail';
                                  }
                                  setState(() {});
                                },
                                loop: false,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    return SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            CustomTextInputField(
                                                labelText: "Barcode",
                                                isHideLable: true,
                                                readOnly: false,
                                                focusNode: _focusBarCode,
                                                controller: _barCode,
                                                onFieldSubmitted: (value) {
                                                  if (value.isNotEmpty) {
                                                    BlocProvider.of<AssetsBloc>(
                                                            context)
                                                        .add(
                                                            GetDetailAssetEvent(
                                                                value));
                                                    _barCode.clear();
                                                    _focusBarCode
                                                        .requestFocus();
                                                  }
                                                },
                                                suffixIcon: IconButton(
                                                    onPressed: () async {
                                                      await _scanBarcode();
                                                    },
                                                    icon: Icon(Icons.qr_code))),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            _detailAssetModel.ASSET_NAME != null
                                                ? Column(
                                                    children: [
                                                      CustomTextInputField(
                                                          isHideLable: true,
                                                          readOnly: true,
                                                          labelText: "Asset No",
                                                          controller: _assetNo),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      CustomTextInputField(
                                                          isHideLable: true,
                                                          readOnly: true,
                                                          labelText:
                                                              "Asset Name",
                                                          controller:
                                                              _assetName),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      CustomTextInputField(
                                                          isHideLable: true,
                                                          readOnly: true,
                                                          labelText:
                                                              "Used Date",
                                                          controller:
                                                              _usedDate),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      CustomTextInputField(
                                                          isHideLable: true,
                                                          readOnly: true,
                                                          labelText:
                                                              "Life Year",
                                                          controller:
                                                              _lifeYear),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      CustomTextInputField(
                                                          isHideLable: true,
                                                          readOnly: true,
                                                          labelText:
                                                              "Asset Status",
                                                          controller:
                                                              _assetStatus),
                                                    ],
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            CustomTextInputField(
                                                isHideLable: true,
                                                readOnly: true,
                                                labelText: "Company",
                                                controller: _company),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomTextInputField(
                                                isHideLable: true,
                                                readOnly: true,
                                                labelText: "Branch",
                                                controller: _branchName),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomTextInputField(
                                                isHideLable: true,
                                                readOnly: true,
                                                labelText: "Building",
                                                controller: _building),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomTextInputField(
                                                isHideLable: true,
                                                readOnly: true,
                                                labelText: "Room",
                                                controller: _room),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomTextInputField(
                                                isHideLable: true,
                                                readOnly: true,
                                                labelText: "Location",
                                                controller: _location),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomTextInputField(
                                                isHideLable: true,
                                                readOnly: true,
                                                labelText: "Department",
                                                controller: _department),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomTextInputField(
                                                isHideLable: true,
                                                readOnly: true,
                                                labelText: "Owner",
                                                controller: _owner),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                                itemCount: _detailAssetModel.ASSET_NAME != null
                                    ? 2
                                    : 1,
                                pagination: SwiperPagination(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Row(children: <Widget>[
      Expanded(
          child: Divider(
        color: colorPrimary,
      )),
      SizedBox(
        width: 15,
      ),
      Label(
        "$textTitle",
        color: colorPrimary,
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        width: 15,
      ),
      Expanded(
          child: Divider(
        color: colorPrimary,
      )),
    ]);
  }
}
