part of 'test_unit_bloc.dart';

abstract class TestUnitEvent extends Equatable {
  const TestUnitEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class TestUnitFetch extends TestUnitEvent {
  final String serialNo;

  const TestUnitFetch({required this.serialNo});

  @override
  List<Object?> get props => [serialNo];
}

class FormSubmitted extends TestUnitEvent {
  final List<TestUnitData> sendSerial;
  final Serial serial;
  final bool isOffline;

  const FormSubmitted({
    required this.sendSerial,
    required this.isOffline,
    required this.serial,
  });

  @override
  List<Object?> get props => [sendSerial, serial, isOffline];
}

class FormOfflineSubmitted extends TestUnitEvent {
  final List<TestUnitData> sendSerial;
  // final Serial serial;
  // final bool isOffline;

  const FormOfflineSubmitted({
    required this.sendSerial,
    // required this.isOffline,
    // required this.serial,
  });

  @override
  List<Object?> get props => [sendSerial];
}

class TestUnitRemove extends TestUnitEvent {
  final List<String> serials;
  final bool isClearAll;

  const TestUnitRemove({
    required this.serials,
    this.isClearAll = false,
  });

  @override
  List<Object?> get props => [serials, isClearAll];
}
