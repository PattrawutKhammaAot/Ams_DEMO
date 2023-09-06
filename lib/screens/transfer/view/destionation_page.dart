import 'package:ams_count/blocs/count/count_bloc.dart';
import 'package:ams_count/blocs/transfer/transfer_bloc.dart';
import 'package:ams_count/models/master/departmentModel.dart';
import 'package:ams_count/models/master/locationModel.dart';
import 'package:ams_count/models/transfer/selectdestinationModel.dart';
import 'package:ams_count/models/transfer/transferAsset_outputModel.dart';
import 'package:ams_count/screens/transfer/transfer.dart';
import 'package:ams_count/widgets/custom_dropdown2.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../config/app_constants.dart';
import '../../../config/app_data.dart';
import '../../../data/models/api_response.dart';
import '../../../models/transfer/transferModel.dart';
import '../../../widgets/alert.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key, this.onChange});
  final ValueChanged<bool>? onChange;

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  int _companyID = 0;
  int _branchID = 0;
  int _buildingID = 0;
  int _roomID = 0;
  int _locationID = 0;
  int _departmentID = 0;
  int _ownerID = 0;

  List<TransferModel> assetCode = [];
  List<int>? assetIDs = [];
  List<SelectDestinationDropdownModel> companyModel = [];
  List<SelectDestinationDropdownModel> branchModel = [];
  List<SelectDestinationDropdownModel> buildingModel = [];
  List<SelectDestinationDropdownModel> roomModel = [];
  List<LocationModel> locationModel = [];
  List<DepartmentModel> departemntModel = [];
  List<SelectDestinationDropdownModel> ownerModel = [];
  var arguments = Get.arguments as Map<String, dynamic>?;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    BlocProvider.of<TransferBloc>(context).add(TF_CompanyEvent());
    BlocProvider.of<TransferBloc>(context).add(TF_BranchEvent());
    BlocProvider.of<TransferBloc>(context).add(TF_BuildingEvent());
    BlocProvider.of<TransferBloc>(context).add(TF_RoomEvent());
    BlocProvider.of<CountBloc>(context).add(GetDepartmentEvent());
    BlocProvider.of<CountBloc>(context).add(GetLocationEvent());
    BlocProvider.of<TransferBloc>(context).add(TF_OwnerEvent());
    assetCode = arguments?['assetsCode'];

    _loopGetId();
    super.initState();
  }

  _loopGetId() {
    for (var item in assetCode) {
      assetIDs!.add(item.ID!);
    }
  }

  _validatedropown(int value) {
    if (value == 0) {
      return "Please select items";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TransferBloc, TransferState>(
            listener: (context, state) async {
          if (state is TF_CompanyLoadedState) {
            companyModel = state.item;
            setState(() {});
          }
          if (state is TF_BranchLoadedState) {
            branchModel = state.item;
            setState(() {});
          }
          if (state is TF_BuildingLoadedState) {
            buildingModel = state.item;
            setState(() {});
          }
          if (state is TF_RoomLoadedState) {
            roomModel = state.item;
            setState(() {});
          }

          if (state is TF_OwnerLoadedState) {
            ownerModel = state.item;
            setState(() {});
          }
          if (state is TF_AssetPostLoadedState) {
            if (state.item.STATUS == "SUCCESS") {
              AlertSnackBar.show(
                  title: '${state.item.STATUS}',
                  message: "${state.item.MESSAGE}",
                  type: ReturnStatus.SUCCESS,
                  crossPage: true);

              Get.back(result: {"ischecked": true});
            }
          } else if (state is TF_AssetPostErrorState) {
            AlertSnackBar.show(
                title: 'Exception',
                message: "No internet",
                type: ReturnStatus.SUCCESS,
                crossPage: true);
          }
        }),
        BlocListener<CountBloc, CountState>(listener: (context, state) async {
          if (state is GetDepartmentLoadedState) {
            departemntModel = state.item;
            setState(() {});
          }
          if (state is GetLocationLoadedState) {
            locationModel = state.item;
            setState(() {});
          }
        })
      ],
      child: Scaffold(
        floatingActionButton: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(colorPrimary)),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                var localId = await AppData.getLocalId();
                BlocProvider.of<TransferBloc>(context).add(TF_transferAsset(
                    TransferAssetOutputModel(
                        MOVE_NEW_COMPANYID: _companyID,
                        MOVE_NEW_BRANCHID: _branchID,
                        MOVE_NEW_BUILDINGID: _buildingID,
                        MOVE_NEW_ROOMID: _roomID,
                        MOVE_NEW_LOCATIONID: _locationID,
                        MOVE_NEW_DEPARTMENTID: _departmentID,
                        MOVE_NEW_OWNERID: _ownerID == 0 ? null : _ownerID,
                        MOVE_DATE: null,
                        CREATE_DATE: null,
                        MOVE_REMARK: "-",
                        LIST_ASSET_ID: assetIDs,
                        MOVE_NEW_COSTCENTERID: null,
                        MOVE_NEW_FLOORID: null,
                        CREATE_BY: int.parse(localId))));
              }
            },
            child: Label("Confirm Destination")),
        appBar: AppBar(
          centerTitle: true,
          title: Label(
            "Select Destination",
            fontSize: 20,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomDropdownButton2(
                    validator: (p0) => _validatedropown(_companyID),
                    labelText: "Company",
                    hintText: "Select Company",
                    items: companyModel
                        .map((item) => DropdownMenuItem<String>(
                              value: item.NAME,
                              child: Text(
                                item.NAME ?? "",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      _companyID = companyModel
                              .firstWhere((item) => item.NAME == value)
                              .ID ??
                          0;
                  
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomDropdownButton2(
                    validator: (p0) => _validatedropown(_branchID),
                    hintText: "Select Branch",
                    labelText: "Branch",
                    items: branchModel
                        .map((e) => DropdownMenuItem<String>(
                              value: e.NAME,
                              child: Text(
                                e.NAME ?? "",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      _branchID = branchModel
                              .firstWhere((item) => item.NAME == value)
                              .ID ??
                          0;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomDropdownButton2(
                    validator: (p0) => _validatedropown(_buildingID),
                    hintText: "Select Building",
                    labelText: "Building",
                    items: buildingModel
                        .map((e) => DropdownMenuItem<String>(
                              value: e.NAME,
                              child: Text(
                                e.NAME ?? "",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      _buildingID = buildingModel
                              .firstWhere((item) => item.NAME == value)
                              .ID ??
                          0;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomDropdownButton2(
                    validator: (p0) => _validatedropown(_roomID),
                    hintText: "Select Room",
                    labelText: "Room",
                    items: roomModel
                        .map((e) => DropdownMenuItem<String>(
                              value: e.NAME,
                              child: Text(
                                e.NAME ?? "",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      _roomID = roomModel
                              .firstWhere((item) => item.NAME == value)
                              .ID ??
                          0;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomDropdownButton2(
                    validator: (p0) => _validatedropown(_locationID),
                    hintText: "Select Location",
                    labelText: "Location",
                    items: locationModel
                        .map((e) => DropdownMenuItem<String>(
                              value: e.LOCATION_NAME,
                              child: Text(
                                e.LOCATION_NAME ?? "",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      _locationID = locationModel
                              .firstWhere((item) => item.LOCATION_NAME == value)
                              .LOCATION_ID ??
                          0;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomDropdownButton2(
                    validator: (p0) => _validatedropown(_departmentID),
                    hintText: "Select Department",
                    labelText: "Department",
                    items: departemntModel
                        .map((e) => DropdownMenuItem<String>(
                              value: e.DEPARTMENT_NAME,
                              child: Text(
                                e.DEPARTMENT_NAME ?? "",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      _departmentID = departemntModel
                              .firstWhere(
                                  (item) => item.DEPARTMENT_NAME == value)
                              .DEPARTMENT_ID ??
                          0;

                      
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomDropdownButton2(
                    labelText: "Owner",
                    hintText: "Select Owner",
                    items: ownerModel
                        .map((e) => DropdownMenuItem<String>(
                              value: e.NAME,
                              child: Text(
                                e.NAME ?? "",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      _ownerID = ownerModel
                              .firstWhere((item) => item.NAME == value)
                              .ID ??
                          0;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
