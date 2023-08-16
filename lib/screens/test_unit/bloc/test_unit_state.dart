part of 'test_unit_bloc.dart';

class TestUnitState extends Equatable {

  final List<Serial> serials;
  final FetchStatus status;
  final String message;
  final String? progress;

  const TestUnitState({
    this.serials = const [],
    this.status = FetchStatus.init,
    this.message = "",
    this.progress = "",
  });

  TestUnitState copyWith({
    List<Serial>? serials,
    FetchStatus? status,
    String? message,
    String? progress,
  }) {
    return TestUnitState(
      serials: serials ?? this.serials,
      status: status ?? this.status,
      message: message ?? this.message,
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object> get props => [
        serials,
        status,
        message,
      ];
}

class TestUnitInitial extends TestUnitState {
  @override
  List<Object> get props => [];
}
