import 'dart:convert';
import 'dart:io';

import 'package:ams_count/models/count/CountScan_output.dart';
import 'package:ams_count/models/count/countScanAssetsModel.dart';
import 'package:ams_count/models/count/listImageAssetModel.dart';
import 'package:ams_count/models/count/main/countScanAssetMain.dart';
import 'package:ams_count/models/count/uploadImage_output_Model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../config/api_path.dart';
import '../../config/app_data.dart';
import '../../data/network/providers/api_controller.dart';
import '../../models/count/countPlanModel.dart';
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
    on<PostCountScanAssetListEvent>(
      (event, emit) async {
        try {
          emit(CountScanAssetsListLoadingState());
          final mlist = await fetchCountScanASsetsModelList(event.items);
          emit(CountScanAssetsListLoadedState(mlist));
        } catch (e) {
          emit(CountScanAssetsListErrorState(e.toString()));
        }
      },
    );
    on<PostCountScanAssetEvent>(
      (event, emit) async {
        try {
          emit(CountScanAssetsLoadingState());
          final mlist = await fetchCountScanAssetsModel(event.items);
          emit(CountScanAssetsLoadedState(mlist));
        } catch (e) {
          emit(CountScanAssetsErrorState(e.toString()));
        }
      },
    );
    on<GetListImageAssetsEvent>(
      (event, emit) async {
        try {
          emit(GetListImageAssetLoadingState());
          final mlist = await fetchGetListImageAssets();
          emit(GetListImageAssetLoadedState(mlist));
        } catch (e) {
          emit(GetListImageAssetErrorState(e.toString()));
        }
      },
    );
    on<UploadImageEvent>(
      (event, emit) async {
        try {
          emit(UploadImageLoadingState());
          final mlist = await fetchUploadImage(event.items);
          emit(UploadImageLoadedState());
        } catch (e) {
          emit(UploadImageErrorState(e.toString()));
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

  Future<CountScanMain> fetchCountScanASsetsModelList(
      List<CountScan_OutputModel> output) async {
    var configHost = await AppData.getApiUrl();
    late String token = "";
    token = await AppData.getToken();
    try {
      Response responese = await dio.post(
        '${configHost}Count/CountScanAsset',
        data: json.encode(output),
        options: Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          "Application-Key": appKey,
          "Action-By": await AppData.getUserName(),
          "Locale-Id": await AppData.getLocalId(),
        }),
      );

      printInfo(info: "${responese.data}");
      // var itemData = responese.data['data'];
      CountScanMain post = CountScanMain.fromJson(responese.data);

      return post;
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    }
  }

  Future<CountScanMain> fetchCountScanAssetsModel(
      CountScan_OutputModel output) async {
    late String token = "";
    token = await AppData.getToken();
    var configHost = await AppData.getApiUrl();

    printInfo(info: "${output.toJson()}");
    try {
      Response responese = await dio.post(
        '${configHost}Count/CountSaveStatusAsset',
        data: json.encode(output),
        options: Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          "Application-Key": appKey,
          "Action-By": await AppData.getUserName(),
          "Locale-Id": await AppData.getLocalId(),
        }),
      );

      printInfo(info: "${configHost}");
      printInfo(info: "${responese.data}");

      CountScanMain post = CountScanMain.fromJson(responese.data);

      return post;
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    }
  }

  Future<List<ListImageAssetModel>> fetchGetListImageAssets() async {
    try {
      var apiController = APIController();
      var response = await apiController.getData('Count/GetListImageAsset', "",
          useAuth: true);

      var itemData = response['data'];
      List<ListImageAssetModel> post = itemData
          .map<ListImageAssetModel>(
              (json) => ListImageAssetModel.fromJson(json))
          .toList();

      printInfo(info: "${itemData}");
      return post;
    } catch (e, s) {
      printError(info: "Exception occured: $e StackTrace: $s");
      throw Exception();
    }
  }

  Future<CountScanMain> fetchUploadImage(UploadImageModelOutput output) async {
    late String token = "";
    token = await AppData.getToken();
    var configHost = await AppData.getApiUrl();

    Dio dio = Dio();

    dio.options.headers['Authorization'] = 'Bearer $token';
    dio.options.headers['Application-Key'] = appKey;
    dio.options.headers['Action-By'] = await AppData.getUserName();
    dio.options.headers['Locale-Id'] = await AppData.getLocalId();
    dio.options.headers['Content-Type'] = 'multipart/form-data';

    try {
      FormData formData = FormData.fromMap({
        "assetCode": output.ASSETS_CODE,
        "files": MultipartFile.fromFileSync(
          output.FILES!.path,
          filename: "${output.ASSETS_CODE}.jpg",
        ),
      });

      Response response = await dio.post(
        '${configHost}Count/CountUploadImage',
        data: formData,
      );

      printInfo(info: "${configHost}");
      printInfo(info: "${response.data}");

      return CountScanMain();
    } catch (e, s) {
      printError(info: "Exception occurred: $e StackTrace: $s");
      throw Exception();
    }
  }
}
