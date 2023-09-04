import 'package:ams_count/models/dashboard/dashboardAssetStatusModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../data/network/providers/api_controller.dart';
import '../../models/assets/getDetailAssetModel.dart';

part 'assets_event.dart';
part 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  AssetsBloc() : super(AssetsInitial()) {
    on<AssetsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetDashBoardAssetStatusEvent>(
      (event, emit) async {
        try {
          emit(GetDashBoardAssetStatusLoadingState());
          final mlist = await fetchGetDashboardStatus();
          emit(GetDashBoardAssetStatusLoadedState(mlist));
        } catch (e) {
          emit(GetDashBoardAssetStatusErrorState(e.toString()));
        }
      },
    );
     on<GetDetailAssetEvent>(
      (event, emit) async {
        try {
          emit(GetDetailAssetLoadingState());
          final mlist = await fetchGetDetailAsset(event.assetCode);
          emit(GetDetailAssetLoadedState(mlist));
        } catch (e) {
          emit(GetDetailAssetErrorState(e.toString()));
        }
      },
    );
  }

  Future<DashBoardAssetStatusModel> fetchGetDashboardStatus() async {
    try {
      var apiController = APIController();
      var response = await apiController
          .getData('Asset/GetDashboardAssetStatus', "", useAuth: true);

      var itemData = response['data'];
      DashBoardAssetStatusModel post =
          DashBoardAssetStatusModel.fromJson(itemData);

      if (response['status'] == "SUCCESS") {
        await DashBoardAssetStatusModel().update(values: {
          DashboardField.RESULT_ALL: post.RESULT_ALL,
          DashboardField.RESULT_NORMAL: post.RESULT_NORMAL,
          DashboardField.RESULT_REPAIR: post.RESULT_REPAIR,
          DashboardField.RESULT_BORROW: post.RESULT_BORROW,
          DashboardField.RESULT_SALE: post.RESULT_SALE,
          DashboardField.RESULT_WRITEOFF: post.RESULT_WRITEOFF,
        });
      }

      return post;
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    }
  }

  Future<GetDetailAssetModel> fetchGetDetailAsset(String param) async {
    try {
      var apiController = APIController();
      var response = await apiController
          .getData('Asset/GetDetailAsset', "assetCode=$param", useAuth: true);

      var itemData = response['data'];

      GetDetailAssetModel post = GetDetailAssetModel.fromJson(itemData);
      return post;
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    }
  }
}
