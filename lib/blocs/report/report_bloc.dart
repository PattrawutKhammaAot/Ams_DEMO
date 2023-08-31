import 'package:ams_count/widgets/alert.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../data/models/api_response.dart';
import '../../data/network/providers/api_controller.dart';
import '../../models/report/listCountDetail_report_model.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial()) {
    on<ReportEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetListCountDetailForReportEvent>(
      (event, emit) async {
        try {
          emit(GetListCountDetailLoadingState());
          final mlist = await fetchGetListDetail(event.planCode);
          emit(GetListCountDetailLoadedState(mlist));
        } catch (e) {
          emit(GetListCountDetailErrorState(e.toString()));
        }
      },
    );
  }
  Future<List<ListCountDetailReportModel>> fetchGetListDetail(
      String param) async {
    try {
      var apiController = APIController();
      var response = await apiController.getData(
          'Count/GetListCountDetailForReport', "planCode=${param}",
          useAuth: true);

      if (response['status'] == "SUCCESS") {
        var itemData = response['data'];

        List<ListCountDetailReportModel> post = itemData
            .map<ListCountDetailReportModel>(
                (json) => ListCountDetailReportModel.fromJson(json))
            .toList();

        // if (response['status'] == "SUCCESS") {
        //   printInfo(info: "Test Update ");
        //   await DashBoardAssetStatusModel().update(values: {
        //     DashboardField.RESULT_ALL: post.RESULT_ALL,
        //     DashboardField.RESULT_NORMAL: post.RESULT_NORMAL,
        //     DashboardField.RESULT_REPAIR: post.RESULT_REPAIR,
        //     DashboardField.RESULT_BORROW: post.RESULT_BORROW,
        //     DashboardField.RESULT_SALE: post.RESULT_SALE,
        //     DashboardField.RESULT_WRITEOFF: post.RESULT_WRITEOFF,
        //   });
        // }

        return post;
      } else {
        Alert.show(
            title: '${response['status']}',
            message: '${response['message']}',
            type: ReturnStatus.WARNING,
            crossPage: true);
        return [];
      }
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    }
  }
}
