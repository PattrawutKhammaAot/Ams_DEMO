import 'package:ams_count/data/database/dbsqlite.dart';
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

        var querySql = await ListCountDetailReportModel().query();
        if (querySql.isEmpty) {
          for (var item in post) {
            await ListCountDetailReportModel().insert(item.toJson());
          }
        } else if (querySql.isNotEmpty && param == "") {
          await DbSqlite()
              .deleteAll(tableName: ListCountDetailReportField.TABLE_NAME);
          for (var item in post) {
            await ListCountDetailReportModel().insert(item.toJson());
          }
        }

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
