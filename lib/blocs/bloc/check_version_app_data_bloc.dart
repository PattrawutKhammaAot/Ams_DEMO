import 'package:ams_count/models/checkversion/checkversionModel.dart';
import 'package:ams_count/widgets/alert_new.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../config/app_data.dart';
import '../../data/network/providers/api_controller.dart';

part 'check_version_app_data_event.dart';
part 'check_version_app_data_state.dart';

class CheckVersionAppDataBloc
    extends Bloc<CheckVersionAppDataEvent, CheckVersionAppDataState> {
  Dio dio = Dio();
  CheckVersionAppDataBloc() : super(CheckVersionAppDataInitial()) {
    on<CheckVersionAppDataEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CheckAppVersionEvent>(
      (event, emit) async {
        try {
          emit(CheckVersionLoadingState());
          final mlist = await fetchCheckVersion(event.buildNumber!);
          emit(CheckVersionLoadedState(mlist));
        } catch (e) {
          emit(CheckVersionErrorState(e.toString()));
        }
      },
    );
  }

  Future<CheckVersionModel> fetchCheckVersion(int buildNumber) async {
    try {
      var apiController = APIController();
      var response = await apiController.getData(
          'App/CheckVersion', "buildNumber=${buildNumber}",
          useAuth: false);

      CheckVersionModel result = CheckVersionModel.fromJson(response['data']);
      printInfo(info: "UpdateNow123");

      return result;
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    }
  }
}
