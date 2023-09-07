import 'dart:convert';
import 'dart:io';

import 'package:ams_count/models/transfer/selectdestinationModel.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../config/api_path.dart';
import '../../config/app_data.dart';
import '../../data/network/providers/api_controller.dart';
import '../../models/count/main/countScanAssetMain.dart';
import '../../models/transfer/transferAsset_outputModel.dart';
import '../../models/transfer/transferResponeseModel.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  Dio dio = Dio();
  TransferBloc() : super(TransferInitial()) {
    on<TransferEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<TF_CompanyEvent>((event, emit) async {
      try {
        emit(TF_CompanyLoadingState());
        final mlist = await fetchGetDetailAsset("GetCompany");
        emit(TF_CompanyLoadedState(mlist));
      } catch (e) {
        emit(TF_CompanyErrorState(e.toString()));
      }
    });
    on<TF_BranchEvent>((event, emit) async {
      try {
        emit(TF_BranchLoadingState());
        final mlist = await fetchGetDetailAsset("GetBranch");
        emit(TF_BranchLoadedState(mlist));
      } catch (e) {
        emit(TF_BranchErrorState(e.toString()));
      }
    });
    on<TF_BuildingEvent>((event, emit) async {
      try {
        emit(TF_BuildingLoadingState());
        final mlist = await fetchGetDetailAsset("GetBuilding");
        emit(TF_BuildingLoadedState(mlist));
      } catch (e) {
        emit(TF_BuildingErrorState(e.toString()));
      }
    });
    on<TF_RoomEvent>((event, emit) async {
      try {
        emit(TF_RoomLoadingState());
        final mlist = await fetchGetDetailAsset("GetRoom");
        emit(TF_RoomLoadedState(mlist));
      } catch (e) {
        emit(TF_RoomErrorState(e.toString()));
      }
    });
    // on<TF_LocationEvent>((event, emit) async {
    //   try {
    //     emit(TF_LocationLoadingState());
    //     final mlist = await fetchGetDetailAsset("GetLocation");
    //     emit(TF_LocationLoadedState(mlist));
    //   } catch (e) {
    //     emit(TF_LocationErrorState(e.toString()));
    //   }
    // });
    on<TF_transferAsset>((event, emit) async {
      try {
        emit(TF_AssetPostLoadingState());
        final mlist = await fetchPostTransferAsset(event.output);
        emit(TF_AssetPostLoadedState(mlist));
      } catch (e) {
        emit(TF_AssetPostErrorState(e.toString()));
      }
    });
    on<TF_OwnerEvent>((event, emit) async {
      try {
        emit(TF_OwnerLoadingState());
        final mlist = await fetchGetDetailAsset("GetOwner");
        emit(TF_OwnerLoadedState(mlist));
      } catch (e) {
        emit(TF_OwnerErrorState(e.toString()));
      }
    });
  }

  Future<List<SelectDestinationDropdownModel>> fetchGetDetailAsset(
      String apifunctions) async {
    try {
      var apiController = APIController();
      var response = await apiController.getData('Master/$apifunctions', "",
          useAuth: true);

      var itemData = response['data'];

      List<SelectDestinationDropdownModel> post = itemData
          .map<SelectDestinationDropdownModel>(
              (json) => SelectDestinationDropdownModel.fromJson(json))
          .toList();
      return post;
    } catch (e, s) {
      throw Exception();
    }
  }

  Future<TransferResponeseModel> fetchPostTransferAsset(
      TransferAssetOutputModel output) async {
    var configHost = await AppData.getApiUrl();
    late String token = "";
    token = await AppData.getToken();

    

    try {
      Response responese = await dio.post(
        '${configHost}Asset/TransferAsset',
        data: json.encode(output),
        options: Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          "Application-Key": appKey,
          "Action-By": await AppData.getUserName(),
          "Locale-Id": await AppData.getLocalId(),
        }),
      );

      TransferResponeseModel post =
          TransferResponeseModel.fromJson(responese.data);

      return post;
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    }
  }
}
