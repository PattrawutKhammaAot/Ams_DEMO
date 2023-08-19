import 'package:ams_count/screens/count/count.dart';
import 'package:ams_count/screens/count/view/scan_page.dart';
import 'package:ams_count/screens/gallery/view/gallery_page.dart';
import 'package:ams_count/screens/login/login.dart';
import 'package:ams_count/screens/myAssets/view/myAssets_Page.dart';
import 'package:ams_count/screens/reportPage/reportPage.dart';
import 'package:ams_count/screens/transfer/transfer.dart';
import 'package:get/get.dart';
import 'package:ams_count/screens/connection_setting/connection_setting.dart';
import 'package:ams_count/screens/test_unit/test_unit.dart';
import 'package:ams_count/screens/view_summary_unit/view_summary_unit.dart';

import '../screens/home/home.dart';
import '../screens/splash/splash.dart';
//
// final Map<String, WidgetBuilder> routes = {
//   // '/': (BuildContext context) => HomePage(),
//   '/splash': (BuildContext context) => const SplashPage(),
//
//   '/home': (BuildContext context) => const HomePage(),
//   // '/settings': (BuildContext context) => SettingsPage(),
// };

final List<GetPage<dynamic>> routes = [
  GetPage(name: '/splash', page: () => const SplashPage()),
  GetPage(name: '/', page: () => const HomePage()),
  GetPage(
      name: '/connectionSetting', page: () => const ConnectionSettingPage()),
  GetPage(name: '/testUnit', page: () => const TestUnitPage()),
  GetPage(name: '/summaryUnit', page: () => const ViewSummaryUnitPage()),
  GetPage(name: '/summaryUnitOffline', page: () => const ViewSummaryUnitPage()),
  GetPage(name: '/Login', page: () => const LoginPage()),
  GetPage(name: '/MyassetsPage', page: () => const MyAssetsPage()),
  GetPage(name: '/CountPage', page: () => const CountPage()),
  GetPage(name: '/ScanPage', page: () => const ScanPage()),
  GetPage(name: '/GalleryPage', page: () => const GalleryPage()),
  GetPage(name: '/ReportPage', page: () => const ReportPage()),
  GetPage(name: '/TransferPage', page: () => const TransferPage()),
];
