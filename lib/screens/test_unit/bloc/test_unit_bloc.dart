import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../app.dart';
import '../../../data/models/test_unit/serial_data_response.dart';
import '../../../data/models/test_unit/test_unit_request.dart';
import '../../../data/repositories/test_unit/test_unit_repository.dart';

part 'test_unit_event.dart';

part 'test_unit_state.dart';

class TestUnitBloc extends Bloc<TestUnitEvent, TestUnitState> {
  final TestUnitRepository _repository;

  TestUnitBloc({required TestUnitRepository repository})
      : _repository = repository,
        super(TestUnitInitial()) {
    on<TestUnitEvent>((event, emit) {});

    on<TestUnitFetch>((event, emit) async {
      try {
        emit(state.copyWith(status: FetchStatus.fetching, serials: []));
        // await Future.delayed(const Duration(seconds: 3));

        List<Serial> serials = await _repository.getSerial(event.serialNo);
        if (serials.isNotEmpty) {
          emit(state.copyWith(status: FetchStatus.success, serials: serials));
        } else {
          emit(state.copyWith(status: FetchStatus.failed, serials: [], message: "No data Found"));
        }
      } catch (e) {
        if (e == 'No internet connection' || e.toString().contains('No Internet')) {
          emit(state.copyWith(status: FetchStatus.connectionFailed, serials: [], message: e.toString()));
        } else {
          emit(state.copyWith(status: FetchStatus.failed, serials: [], message: e.toString()));
        }
      }
    });

    on<FormSubmitted>((event, emit) async {
      try {
        emit(state.copyWith(status: FetchStatus.fetching, serials: []));
        // await Future.delayed(const Duration(seconds: 3));

        if (!event.isOffline) {
          /// Send Online
          TestUnitRequest requestData = TestUnitRequest();
          List<TestUnitData> data = List<TestUnitData>.empty(growable: true);
          data = event.sendSerial;
          requestData.data = data;
          var resp = await _repository.sendSerial(requestData);
          if (resp.result == "SUCCESS") {
            emit(state.copyWith(status: FetchStatus.sendSuccess));
          } else {
            await _repository.saveSerial(event.serial);
            emit(state.copyWith(status: FetchStatus.connectionFailed, serials: [], message: "Cannot send data"));
          }
        } else {
          /// Save Offline
          await _repository.saveSerial(event.serial);
          emit(state.copyWith(status: FetchStatus.saved));
        }
      } catch (e) {
        emit(state.copyWith(status: FetchStatus.connectionFailed, serials: [], message: e.toString()));
      }
    });

    on<FormOfflineSubmitted>((event, emit) async {
      try {
        // emit(state.copyWith(status: FetchStatus.fetching, serials: []));

        int count = 0;
        for (var serial in event.sendSerial) {
          count++;
          emit(state.copyWith(status: FetchStatus.sending, progress: 'Sending $count/${event.sendSerial.length}'));

          /// Get Serial Detial
          List<Serial> serials = await _repository.getSerial(serial.serial.toString());
          if (serials.isNotEmpty) {
            //emit(state.copyWith(status: FetchStatus.success, serials: serials));
            var respSerial = serials[0];

            /// Send Online
            TestUnitRequest requestData = TestUnitRequest();
            List<TestUnitData> data = List<TestUnitData>.empty(growable: true);
            // data = event.sendSerial;
            data.add(TestUnitData(
              orderId: int.tryParse(respSerial.orderId.toString()) ?? 0,
              prdOrderNo: respSerial.prdOrderNo,
              itemCode: respSerial.itemcode.toString(),
              //serial.itemCode,
              serial: serial.serial,
              rL1L2: serial.rL1L2,
              rL2L3: serial.rL2L3,
              rL3L1: serial.rL3L1,
              cL1L2: serial.cL1L2,
              cL2L3: serial.cL2L3,
              cL3L1: serial.cL3L1,
              hvTest: true, // serial.hvTest,
            ));
            requestData.data = data;
            var resp = await _repository.sendSerial(requestData);
            if (resp.result == "SUCCESS") {
              emit(state.copyWith(status: FetchStatus.sendSuccess, progress: 'Send complete $count/${event.sendSerial.length}'));
            } else {
              // await _repository.saveSerial(event.serial);
              emit(state.copyWith(status: FetchStatus.sendFailed, serials: [], message: "Cannot send data\nSerial No. : ${serial.serial}"));
              break;
            }
          } else {
            emit(state.copyWith(status: FetchStatus.sendFailed, serials: [], message: "No data Found\nSerial No. : ${serial.serial}"));
            break;
          }
        }
      } catch (e) {
        emit(state.copyWith(status: FetchStatus.sendFailed, serials: [], message: "Cannot send data"));
      }
    });

    on<TestUnitRemove>((event, emit) async {
      try {
        emit(state.copyWith(status: FetchStatus.fetching));

        if (!event.isClearAll) {
          await _repository.removeSerial(event.serials);
        } else {
          await _repository.removeAllSerial();
        }
        emit(state.copyWith(status: FetchStatus.removeSuccess));
      } catch (e) {
        emit(state.copyWith(status: FetchStatus.failed, message: 'Delete Failed!'));
      }
    });
  }
}
