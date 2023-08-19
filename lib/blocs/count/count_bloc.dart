import 'dart:convert';

import 'package:ams_count/data/models/default_response.dart';
import 'package:ams_count/data/network/providers/api_controller.dart';
import 'package:ams_count/models/responeModel.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../models/listCountPlanModel.dart';

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
  }
  Future<List<CountPlanModel>> fetchGetListCountPlan() async {
    try {
      // Response responese = await dio.get(
      //   "${APIController().getData("Count/GetListCountPlan", "", useAuth: true)}",
      // );

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
}
