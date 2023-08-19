import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../models/count/listCountPlanModel.dart';
import '../../data/network/providers/api_controller.dart';
import '../../models/count/responeModel.dart';
import '../../models/master/departmentModel.dart';
import '../../models/master/locationModel.dart';
import '../../models/master/statusAssetCountModel.dart';

part 'count_event.dart';
part 'count_state.dart';

class CountBloc extends Bloc<CountEvent, CountState> {
  Dio dio = Dio();
  CountBloc() : super(CountInitial()) {
    on<CountEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetListCountPlanEvent>(
      (event, emit) async {
        try {
          emit(GetListCountPlanLoadingState());
          final mlist = await fetchGetListCountPlan();
          emit(GetListCountPlanLoadedState(mlist));
        } catch (e) {
          emit(GetListCountPlanErrorState(e.toString()));
        }
      },
    );
    on<CheckAllTotalEvent>(
      (event, emit) async {
        try {
          emit(CheckAllLoadingState());
          final mlist =
              await fetchCheck(apinfunctiong: "GetCountCheckAllTotal");
          emit(CheckAllLoadedState(mlist));
        } catch (e) {
          emit(CheckAllErrorState(e.toString()));
        }
      },
    );
    on<CheckTotalEvent>(
      (event, emit) async {
        try {
          emit(CheckTotalLoadingState());
          final mlist = await fetchCheck(apinfunctiong: "GetCountCheckTotal");
          emit(CheckTotalLoadedState(mlist));
        } catch (e) {
          emit(CheckTotalErrorState(e.toString()));
        }
      },
    );
    on<CheckUncheckEvent>(
      (event, emit) async {
        try {
          emit(CheckUncheckLoadingState());
          final mlist =
              await fetchCheck(apinfunctiong: "GetCountCheckUncheckTotal");
          emit(CheckUncheckLoadedState(mlist));
        } catch (e) {
          emit(CheckUncheckErrorState(e.toString()));
        }
      },
    );

    on<GetLocationEvent>(
      (event, emit) async {
        try {
          emit(GetLocationLoadingState());
          final mlist = await fetchGetLocation();
          emit(GetLocationLoadedState(mlist));
        } catch (e) {
          emit(GetLocationErrorState(e.toString()));
        }
      },
    );
    on<GetDepartmentEvent>(
      (event, emit) async {
        try {
          emit(GetDepartmentLoadingState());
          final mlist = await fetchGetDepartment();
          emit(GetDepartmentLoadedState(mlist));
        } catch (e) {
          emit(GetDepartmentErrorState(e.toString()));
        }
      },
    );
    on<GetStatusAssetsCountEvent>(
      (event, emit) async {
        try {
          emit(GetStatusAssetLoadingState());
          final mlist = await fetchGetStatusAssetCount();
          emit(GetStatusAssetLoadedState(mlist));
        } catch (e) {
          emit(GetStatusAssetErrorState(e.toString()));
        }
      },
    );
  }
  Future<List<CountPlanModel>> fetchGetListCountPlan() async {
    try {
      var apiController = APIController();
      var response = await apiController.getData('Count/GetListCountPlan', "",
          useAuth: true);

      var itemData = response['data'];
      List<CountPlanModel> post = itemData
          .map<CountPlanModel>((json) => CountPlanModel.fromJson(json))
          .toList();

      return post;
    } catch (e, s) {
      printError(info: "Exception occured: $e StackTrace: $s");
      throw Exception();
    }
  }

  Future<ResponseModel> fetchCheck({required String? apinfunctiong}) async {
    try {
      var apiController = APIController();
      var response = await apiController.getData('Count/${apinfunctiong}', "",
          useAuth: true);

      ResponseModel post = ResponseModel.fromJson(response);

      return post;
    } catch (e, s) {
      printError(info: "Exception occured: $e StackTrace: $s");
      throw Exception();
    }
  }

  Future<List<LocationModel>> fetchGetLocation() async {
    try {
      var apiController = APIController();
      var response =
          await apiController.getData('Master/GetLocation', "", useAuth: true);

      var itemData = response['data'];
      List<LocationModel> post = itemData
          .map<LocationModel>((json) => LocationModel.fromJson(json))
          .toList();

      return post;
    } catch (e, s) {
      printError(info: "Exception occured: $e StackTrace: $s");
      throw Exception();
    }
  }

  Future<List<DepartmentModel>> fetchGetDepartment() async {
    try {
      var apiController = APIController();
      var response = await apiController.getData('Master/GetDepartment', "",
          useAuth: true);

      var itemData = response['data'];
      List<DepartmentModel> post = itemData
          .map<DepartmentModel>((json) => DepartmentModel.fromJson(json))
          .toList();

      return post;
    } catch (e, s) {
      printError(info: "Exception occured: $e StackTrace: $s");
      throw Exception();
    }
  }

  Future<List<StatusAssetCountModel>> fetchGetStatusAssetCount() async {
    try {
      var apiController = APIController();
      var response = await apiController
          .getData('Master/GetStatusAssetCount', "", useAuth: true);

      var itemData = response['data'];
      List<StatusAssetCountModel> post = itemData
          .map<StatusAssetCountModel>(
              (json) => StatusAssetCountModel.fromJson(json))
          .toList();

      return post;
    } catch (e, s) {
      printError(info: "Exception occured: $e StackTrace: $s");
      throw Exception();
    }
  }
}
