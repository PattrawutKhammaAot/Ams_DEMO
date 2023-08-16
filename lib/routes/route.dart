
import 'package:ams_count/screens/login/login.dart';
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


final List<GetPage<dynamic>> routes =   [

   GetPage(name: '/splash', page: () => const SplashPage()),
   GetPage(name: '/', page: () => const HomePage()),
   GetPage(name: '/connectionSetting', page: () => const ConnectionSettingPage()),
   GetPage(name: '/testUnit', page: () => const TestUnitPage()),
   GetPage(name: '/summaryUnit', page: () => const ViewSummaryUnitPage( )),
   GetPage(name: '/summaryUnitOffline', page: () => const ViewSummaryUnitPage( ) ),
   GetPage(name: '/Login', page: () => const LoginPage()),

];