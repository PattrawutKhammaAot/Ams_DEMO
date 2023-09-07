import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/models/transfer/transferModel.dart';
import 'package:ams_count/screens/transfer/transfer.dart';
import 'package:ams_count/widgets/alert.dart';
import 'package:ams_count/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../blocs/asset/assets_bloc.dart';
import '../../../config/app_data.dart';
import '../../../data/models/api_response.dart';
import '../../../models/assets/getDetailAssetModel.dart';
import '../../../widgets/label.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  List<TransferModel> listTransfer = [];
  List<bool> isVisibleList = [];
  TextEditingController _assetNo = TextEditingController();

  bool isVisible = false;
  FocusNode focusAsset = FocusNode();
  bool isDeleteList = false;
  var arguments = Get.arguments as Map<String, dynamic>?;

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
          _assetNo.clear();
          focusAsset.requestFocus();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AssetsBloc, AssetsState>(listener: (context, state) async {
          if (state is GetDetailAssetLoadedState) {
            var value = TransferModel(
                ID: state.item.ASSET_ID,
                ASSET_NO: _assetNo.text,
                ASSET_NAME: state.item.ASSET_NAME,
                COMPANY: state.item.COMPANY_NAME,
                BRAND: state.item.BRAND_NAME,
                BUILDING: state.item.BUILDING_NAME,
                ROOM: state.item.ROOM_NAME,
                LOCATION: state.item.LOCATION_NAME,
                OWNER: state.item.OWNER_NAME,
                DEPARTMENT: state.item.DEPARTMENT_NAME);

            // ตรวจสอบว่า ASSET_NO ซ้ำกันหรือไม่
            if (!listTransfer
                .any((element) => element.ASSET_NO == value.ASSET_NO)) {
              listTransfer.add(value);
            } else {
              // ASSET_NO ซ้ำกัน
              AlertSnackBar.show(
                title: 'Warning',
                message: "มีหมายเลขสินทรัพย์ในรายการแล้ว",
                type: ReturnStatus.WARNING,
                crossPage: true,
              );
            }

            _assetNo.clear();
            focusAsset.requestFocus();
            isVisibleList =
                List.generate(listTransfer.length, (index) => false);
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
              _assetNo.clear();
              focusAsset.requestFocus();
            }
          }
        })
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Label(
            "Transfer",
            fontSize: 22,
          ),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: listTransfer.isEmpty
                      ? MaterialStatePropertyAll(Colors.grey)
                      : MaterialStatePropertyAll(colorPrimary)),
              onPressed: () async {
                if (listTransfer.isNotEmpty) {
                  var item = await Get.toNamed('/SelectionDestination',
                      arguments: {'assetsCode': listTransfer});
                  if (item['ischecked'] == true) {
                    listTransfer.clear();
                    setState(() {});
                  }
                } else {
                  AlertSnackBar.show(
                      title: 'Oops something went wrong',
                      message: "Please Scan AssetNo",
                      type: ReturnStatus.WARNING,
                      crossPage: true);
                }
              },
              child: Label("Select Destination")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                color: colorPrimary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Label("Asset No. : "),
                      Expanded(
                          child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          focusNode: focusAsset,
                          autofocus: true,
                          controller: _assetNo,
                          onFieldSubmitted: (value) {
                            if (value.isNotEmpty) {
                              BlocProvider.of<AssetsBloc>(context)
                                  .add(GetDetailAssetEvent(_assetNo.text));
                            }
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              suffixIcon: IconButton(
                                  onPressed: () => _scanBarcode(),
                                  icon: Icon(Icons.qr_code))),
                        ),
                      ))
                    ],
                  ),
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
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: listTransfer.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                        endActionPane: ActionPane(
                          motion: BehindMotion(),
                          children: [
                            SlidableAction(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              borderRadius: BorderRadius.circular(12),
                              spacing: 1,
                              onPressed: (BuildContext context) {
                                listTransfer.removeAt(index);
                                AlertSnackBar.show(
                                    title: 'Succes',
                                    message: "Delete Success",
                                    type: ReturnStatus.SUCCESS,
                                    crossPage: true);
                                setState(() {});
                              },
                              backgroundColor: colorDanger,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white,
                              shape: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isVisibleList[index] =
                                                    !isVisibleList[index];
                                              });
                                            },
                                            icon: isVisibleList[index] == true
                                                ? Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 40,
                                                  )
                                                : Icon(
                                                    Icons.keyboard_arrow_up,
                                                    size: 40,
                                                  )),
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 19,
                                                  vertical: 7,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: colorPrimary),
                                                  color: colorPrimary,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  12),
                                                          topLeft:
                                                              Radius.circular(
                                                                  14)),
                                                ),
                                                child: Text(
                                                  "Asset No : ${listTransfer[index].ASSET_NO}",
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                )),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Label(
                                                "Asset Name : ${listTransfer[index].ASSET_NAME}",
                                                color: colorPrimary,
                                                maxLine: 2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: isVisibleList[index],
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(12),
                                              bottomLeft: Radius.circular(12))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Label(
                                              "Company : ${listTransfer[index].COMPANY ?? "-"}",
                                              color: colorPrimary,
                                            ),
                                            Label(
                                              "Brand : ${listTransfer[index].BRAND ?? "-"}",
                                              color: colorPrimary,
                                            ),
                                            Label(
                                              "Building :${listTransfer[index].BUILDING ?? "-"}",
                                              color: colorPrimary,
                                            ),
                                            Label(
                                              "Room :${listTransfer[index].ROOM ?? "-"}",
                                              color: colorPrimary,
                                            ),
                                            Label(
                                              "Location :${listTransfer[index].LOCATION ?? "-"}",
                                              color: colorPrimary,
                                            ),
                                            Label(
                                              "Department :${listTransfer[index].DEPARTMENT ?? "-"}",
                                              color: colorPrimary,
                                            ),
                                            Label(
                                              "Owner : ${listTransfer[index].OWNER ?? "-"}",
                                              color: colorPrimary,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
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
        "List Asset",
        fontSize: 18,
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
