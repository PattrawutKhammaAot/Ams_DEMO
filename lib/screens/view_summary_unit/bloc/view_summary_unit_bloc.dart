import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../app.dart';
import '../../../data/models/serial_view_test/serial_view_test_response.dart';
import '../../../data/models/test_unit/serial_data_response.dart';
import '../../../data/repositories/view_summary_unit/view_summary_unit_repository.dart';

part 'view_summary_unit_event.dart';

part 'view_summary_unit_state.dart';

class ViewSummaryUnitBloc extends Bloc<ViewSummaryUnitEvent, ViewSummaryUnitState> {
  ViewSummaryUnitBloc({required ViewSummaryUnitRepository repository})
      : _repository = repository,
        super(ViewSummaryUnitInitial()) {
    on<ViewSummaryUnitEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ViewSummaryUnitFetch>(_onViewSummaryUnitFetch);
  }

  final ViewSummaryUnitRepository _repository;

  Future<FutureOr<void>> _onViewSummaryUnitFetch(ViewSummaryUnitFetch event, Emitter<ViewSummaryUnitState> emit) async {
    try {
      emit(state.copyWith(status: FetchStatus.fetching, items: []));

      if (event.isOffline) {
        var serialResult = await _repository.getSerialViewTestFromLocalDb(event.serialNo);
        List<ViewTest> items = serialResult.listViewTest!;
        emit(state.copyWith(status: FetchStatus.success, items: items, serial: serialResult.serial, totalSerial: serialResult.totalSerial));
      } else {
        // await Future.delayed(const Duration(seconds: 3));
        if (event.serialNo.isEmpty) {
          emit(state.copyWith(status: FetchStatus.init));
        } else {
          List<ViewTest> items = await _repository.getSerialViewTest(event.serialNo);
          emit(state.copyWith(status: FetchStatus.success, items: items));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: FetchStatus.failed, items: []));
    }
  }
}
