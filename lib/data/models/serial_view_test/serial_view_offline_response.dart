import '../test_unit/serial_data_response.dart';
import 'serial_view_test_response.dart';

class SerialViewOfflineResponse {
  List<ViewTest>? listViewTest;
  List<Serial>? serial;
  int? totalSerial;

  SerialViewOfflineResponse({this.listViewTest, this.serial, this.totalSerial});
}
