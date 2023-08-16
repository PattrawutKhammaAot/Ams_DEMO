import 'package:ams_count/data/models/serial_view_test/serial_view_test_response.dart';

import '../../database/database.dart';

// import '../test_unit/serial_data_response.dart';
//
// class SerialViewOfflineResponse {
//   List<ViewTest>? listViewTest;
//   List<Serial>? listSerial;
//
//   SerialViewOfflineResponse({
//       this.listViewTest,
//       this.listSerial,
//   });
// }

class SerialResponse {

  List<Serial>? serial;
  List<Serial>? listSerial;

  SerialResponse({
      this.serial,
      this.listSerial,
  });
}
