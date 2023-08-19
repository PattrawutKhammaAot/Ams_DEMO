import 'dart:async';

import 'package:ams_count/data/models/dashboard/DashboardCountPlan.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../data/network/providers/api_controller.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc._() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      emit(HomeInitial());
    });

    on<HomeObserve>((event, emit) {});
    on<HomeScrollChanged>(_onScrollChanged);
    on<HomeLoadJobs>(_onLoadJobs);

    on<HomeEvent_LoadCountDashboard>((event, emit) async {
      try {
        await Future.delayed(Duration(seconds: 1));

        var apiController = APIController();
        var response = await apiController
            .getData('Count/GetCountDashboardCountPlan', "", useAuth: true);

        var ResultResponse = DashboardCountPlan.fromJson(response);
        if (kDebugMode) {
          print(response);
        }
        emit(HomeLoaded(ResultResponse));
      } catch (e) {}
    });
  }

  static final HomeBloc _instance = HomeBloc._();
  factory HomeBloc() => _instance;

  FutureOr<void> _onScrollChanged(
      HomeScrollChanged event, Emitter<HomeState> emit) {
    if (event.scroll) {
      if (kDebugMode) {
        print('isNotScroll');
      }
      emit(HomeIsScrollState());
    } else {
      if (kDebugMode) {
        print('isScroll');
      }
      emit(HomeIsNotScrollState());
    }
  }

  FutureOr<void> _onLoadJobs(HomeLoadJobs event, Emitter<HomeState> emit) {}
}
