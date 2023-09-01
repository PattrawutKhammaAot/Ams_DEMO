import 'dart:convert';
import 'dart:io';

import 'package:ams_count/data/database/dbsqlite.dart';
import 'package:ams_count/models/count/CountScan_output.dart';
import 'package:ams_count/models/count/countScanAssetsModel.dart';
import 'package:ams_count/models/count/listImageAssetModel.dart';
import 'package:ams_count/models/count/main/countScanAssetMain.dart';
import 'package:ams_count/models/count/uploadImage_output_Model.dart';
import 'package:ams_count/widgets/alert_new.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    on<CountEvent>((event, emit) {});
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
    on<PostCountScanAlreadyCheckEvent>(
      (event, emit) async {
        try {
          emit(PostCountScanAlreadyCheckLoadingState());
          final mlist = await fetchCountScanAlreadyChecked(event.items);
          emit(PostCountScanAlreadyCheckLoadedState(mlist));
        } catch (e) {
          emit(PostCountScanAlreadyCheckErrorState(e.toString()));
        }
      },
    );
    on<PostCountScanSaveAssetEvent>(
      (event, emit) async {
        try {
          emit(CountScanSaveAssetsLoadingState());
          final mlist = await fetchCountScanSaveAssetsModel(event.items);
          emit(CountScanSaveAssetsLoadedState(mlist));
        } catch (e) {
          emit(CountScanSaveAssetsErrorState(e.toString()));
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
          emit(UploadImageLoadedState(mlist));
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

      if (response['status'] == "SUCCESS") {
        var itemSql = await CountPlanModel().queryAllRows();
        if (itemSql.isEmpty) {
          for (var item in post) {
            await CountPlanModel().insert(item.toJson());
          }
        } else {
          DbSqlite().deleteAll(tableName: CountPlanField.TABLE_NAME);
          for (var item in post) {
            await CountPlanModel().insert(item.toJson());
          }
        }
      }

      return post;
    } catch (e, s) {
      print(e);
      print(s);
      EasyLoading.showError("$e");
      throw Exception();
    }
  }

  Future<ResponseModel> fetchCheck({required String? apinfunctiong}) async {
    try {
      var apiController = APIController();
      var response = await apiController.getData('Count/${apinfunctiong}', "",
          useAuth: true);

      ResponseModel post = ResponseModel.fromJson(response);
      if (response['status'] == "SUCCES") {
        if (apinfunctiong == 'GetCountCheckTotal') {
          await ResponseModel().update(check: post.DATA);
        }
        if (apinfunctiong == 'GetCountCheckAllTotal') {
          await ResponseModel().update(total: post.DATA);
        }
        if (apinfunctiong == 'GetCountCheckUncheckTotal') {
          await ResponseModel().update(uncheck: post.DATA);
        }
      }

      return post;
    } catch (e, s) {
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
      if (response['status'] == "SUCCESS") {
        var itemSql = await LocationModel().query();
        if (itemSql.isEmpty) {
          for (var item in post) {
            await LocationModel().insert(item.toJson());
          }
        }
      }

      return post;
    } catch (e, s) {
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

      if (response['status'] == "SUCCESS") {
        var itemSql = await DepartmentModel().query();
        if (itemSql.isEmpty) {
          for (var item in post) {
            await DepartmentModel().insert(item.toJson());
          }
        }
      }

      return post;
    } catch (e, s) {
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
      if (response['status'] == "SUCCESS") {
        var itemSql = await StatusAssetCountModel().query();
        if (itemSql.isEmpty) {
          for (var item in post) {
            await StatusAssetCountModel().insert(StatusAssetCountModel(
                STATUS_CODE: item.STATUS_CODE,
                STATUS_ID: item.STATUS_ID,
                STATUS_NAME: item.STATUS_NAME));
          }
        }
      }
      return post;
    } catch (e, s) {
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

      // var itemData = responese.data['data'];
      CountScanMain post = CountScanMain.fromJson(responese.data);

      return post;
    } catch (e, s) {
      throw Exception();
    }
  }

  Future<CountScanMain> fetchCountScanAlreadyChecked(
      CountScan_OutputModel output) async {
    var configHost = await AppData.getApiUrl();
    late String token = "";
    token = await AppData.getToken();
    try {
      Response responese = await dio.post(
        '${configHost}Count/CountScanAssetAlreadyChecked',
        data: json.encode(output),
        options: Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          "Application-Key": appKey,
          "Action-By": await AppData.getUserName(),
          "Locale-Id": await AppData.getLocalId(),
        }),
      );

      // var itemData = responese.data['data'];
      CountScanMain post = CountScanMain.fromJson(responese.data);

      return post;
    } catch (e, s) {
      throw Exception();
    }
  }

  Future<CountScanMain> fetchCountScanSaveAssetsModel(
      CountScan_OutputModel output) async {
    late String token = "";
    token = await AppData.getToken();
    var configHost = await AppData.getApiUrl();

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

      CountScanMain post = CountScanMain.fromJson(responese.data);

      return post;
    } catch (e, s) {
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

      return post;
    } catch (e, s) {
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
        "files": await MultipartFile.fromFileSync(
          output.FILES!.path,
          filename: "${output.ASSETS_CODE}.jpg",
        ),
      });

      Response response = await dio.post(
        '${configHost}Count/CountUploadImage',
        data: formData,
      );

      var itemSql = await ListImageAssetModel().queryAllRows();
      CountScanMain post = CountScanMain.fromJson(response.data);
      if (post.MESSAGE == ["SUCCESS"]) {
        if (itemSql.isNotEmpty) {
          for (var item in itemSql) {
            await ListImageAssetModel()
                .deleteDataByID(item[ListImageAssetField.ID]);
            File(item[ListImageAssetField.URL_IMAGE]).deleteSync();
          }
        }
      } else {
        if (itemSql.isNotEmpty) {
          for (var item in itemSql) {
            if (item[ListImageAssetField.URL_IMAGE] != null) {
              await ListImageAssetModel()
                  .deleteDataByID(item[ListImageAssetField.ID]);

              File(item[ListImageAssetField.URL_IMAGE]).deleteSync();
              EasyLoading.showError(
                  "รูปภาพไม่สามารถอัพโหลดได้ AssetCode = ${item[ListImageAssetField.ASSETS_CODE]}");
            }
          }
        }
      }

      return post;
    } catch (e, s) {
      print(e);
      print(s);

      throw Exception();
    }
  }
}
