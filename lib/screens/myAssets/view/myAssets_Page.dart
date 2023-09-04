import 'package:ams_count/blocs/asset/assets_bloc.dart';
import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/models/assets/getDetailAssetModel.dart';
import 'package:ams_count/widgets/alert.dart';
import 'package:ams_count/widgets/custom_textfield.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../data/models/api_response.dart';

class MyAssetsPage extends StatefulWidget {
  const MyAssetsPage({super.key});

  @override
  State<MyAssetsPage> createState() => _MyAssetsPageState();
}

class _MyAssetsPageState extends State<MyAssetsPage> {
  String textTitle = 'Asset Detail';
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
  FocusNode focusAsset = FocusNode();

  GetDetailAssetModel _detailAssetModel = GetDetailAssetModel();

  _setValueController(GetDetailAssetModel itemModel) {
    _assetName.text = itemModel.ASSET_NAME ?? "-";
    _usedDate.text = itemModel.ASSET_DATE_OF_USE ?? "-";
    _lifeYear.text = itemModel.LIFE_YEAR.toString();
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
        _assetNo.text = res;
        if (_assetNo.text != "-1" && _assetNo.text.isNotEmpty) {
          BlocProvider.of<AssetsBloc>(context)
              .add(GetDetailAssetEvent(_assetNo.text));
        } else {
          AlertSnackBar.show(
              title: 'Barcode Invalid',
              message: 'Please ScanBarcode Again',
              type: ReturnStatus.WARNING,
              crossPage: true);
        }
      }
      printInfo(info: "${_assetNo.text}");
    });
  }

  @override
  void initState() {
    focusAsset.requestFocus();
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
            setState(() {});
          } else if (state is GetDetailAssetErrorState) {
            AlertSnackBar.show(
                title: '${state.error}',
                message: 'Please Connection Internet',
                type: ReturnStatus.WARNING,
                crossPage: true);
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
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Image.network(
                          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
                          fit: BoxFit.fill,
                        ),
                      );
                    } else if (index == 1) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Image.network(
                          "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg",
                          fit: BoxFit.fill,
                        ),
                      );
                    } else if (index == 2) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Image.network(
                          "https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_640.jpg",
                          fit: BoxFit.fill,
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                  itemCount: 3,
                  pagination: SwiperPagination(),
                  control: SwiperControl(color: colorPrimary),
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
                                      child: Column(
                                        children: [
                                          _textInput("Asset No",
                                              enabled: false,
                                              focusNode: focusAsset,
                                              controller: _assetNo,
                                              onFieldSubmitted: (value) {
                                            if (value.isNotEmpty) {
                                              BlocProvider.of<AssetsBloc>(
                                                      context)
                                                  .add(GetDetailAssetEvent(
                                                      value));
                                            }
                                          },
                                              suffixIcon: IconButton(
                                                  onPressed: () async {
                                                    await _scanBarcode();
                                                  },
                                                  icon: Icon(Icons.qr_code))),
                                          _textInput("Asset Name",
                                              controller: _assetName),
                                          _textInput("Used Date",
                                              controller: _usedDate),
                                          _textInput("Life Year",
                                              controller: _lifeYear),
                                          _textInput("Asset Status",
                                              controller: _assetStatus),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          _textInput("Company",
                                              controller: _company),
                                          _textInput("Branch",
                                              controller: _branchName),
                                          _textInput("Building",
                                              controller: _building),
                                          _textInput("Room", controller: _room),
                                          _textInput("Location",
                                              controller: _location),
                                          _textInput("Department",
                                              controller: _department),
                                          _textInput("Owner",
                                              controller: _owner),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                itemCount: 2,
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

  Widget _textInput(String label,
      {Widget? suffixIcon,
      dynamic Function(String)? onFieldSubmitted,
      bool enabled = true,
      TextEditingController? controller,
      FocusNode? focusNode}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextInputField(
        focusNode: focusNode,
        controller: controller,
        isHideLable: true,
        labelText: label,
        readOnly: enabled,
        suffixIcon: suffixIcon,
        onFieldSubmitted: onFieldSubmitted,
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
