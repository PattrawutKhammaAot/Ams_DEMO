import 'dart:convert';
import 'dart:io';

import 'package:ams_count/models/count/responeModel.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../config/api_path.dart';
import '../../config/app_data.dart';
import '../../models/authenticate/logoutModel.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  Dio dio = Dio();
  AuthenticateBloc() : super(AuthenticateInitial()) {
    on<AuthenticateEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LogoutEvent>(
      (event, emit) async {
        try {
          emit(LogoutLoadingState());
          final mlist = await fetchlogout(event.username!);
          emit(LogoutLoadedState(mlist));
        } catch (e) {
          emit(LogoutErrorState(e.toString()));
        }
      },
    );
  }

  Future<ResponseModel> fetchlogout(LogoutModel username) async {
    var configHost = await AppData.getApiUrl();
    late String token = "";
    token = await AppData.getToken();

    printInfo(info: "${username.toJson()}");

    try {
      Response responese = await dio.post(
        '${configHost}Authenticate/logout',
        data: json.encode(username),
        options: Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          "Application-Key": appKey,
          "Action-By": await AppData.getUserName(),
          "Locale-Id": await AppData.getLocalId(),
        }),
      );

      ResponseModel post = ResponseModel.fromJson(responese.data);
      printInfo(info: "${post.toJson()}");
      return post;
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    }
  }
}
