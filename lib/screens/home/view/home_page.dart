import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../app.dart';
import '../../../blocs/home/bloc/home_bloc.dart';
import '../../../blocs/home/home.dart';
import '../../../config/app_constants.dart';
import '../../../config/app_data.dart';
import '../../../data/models/dashboard/DashboardCountPlan.dart';
import '../../../widgets/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }
}

class _HomePageState extends State<HomePage> {
  late PackageInfo packageInfo;
  late String appVersion;
  var name = '';
  int touchedIndex = -1;


  @override
  void initState() {
    appVersion = "";
    getAppInfo();
    initial();
    touchedIndex = -1;
    context.read<HomeBloc>().add(HomeEvent_LoadCountDashboard());

    super.initState();
  }

  void initial() async {
   String _username = await AppData.getUserName();
    setState(()  {
      name =  _username;
    });
  }

  Future<void> getAppInfo() async {
    packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;


    setState(() {
      appVersion = '$version ($buildNumber)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 2.0,
        titleTextStyle: const TextStyle(
          fontSize: 24.0,
        ),
        centerTitle: true,
        title: const Text(
          'DASHBOARD',
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
        ),
      ),
      drawer: CustomDrawer(name: name),
      body: RefreshIndicator(
        onRefresh: () async =>
            context.read<HomeBloc>().add(HomeEvent_LoadCountDashboard()),
        child:
        SingleChildScrollView(
          child :
            Column(
          children: [
            Container(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    final dashboardCountPlan = state.dashboardCountPlan;
                    return CountListWidget(dashboardCountPlan:dashboardCountPlan);
                  }else{
                    return Text("");
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({required this.name,Key? key}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfile(),
          ListTile(
            leading: Icon(Icons.dashboard,color: Colors.red,),
            title: Text("Dashboard"),
            //onTap: () => _showMyDialog(context),
          ),
          ListTile(
            //onTap: () => _PickFile(context),
            title: Text("Import"),
            leading: Icon(Icons.import_contacts, color: Colors.deepOrange),
          ),
          ListTile(
            //onTap: () => _showDialogQRImage(context),
            title: Text("Count"),
            leading: Icon(Icons.qr_code_scanner, color: Colors.green),
          ),
          ListTile(
            //onTap: () => _showScanQRCode(context),
            title: Text("Gallery"),
            leading: const Icon(Icons.photo_library, color: Colors.lightBlue),
          ),
          ListTile(
            //onTap: () => Navigator.pushNamed(context, AppRoute.map),
            title: Text("Export"),
            leading: Icon(Icons.import_export, color: Colors.amber),
          ),
          Spacer(),
          _buildSettingButton(),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  UserAccountsDrawerHeader _buildProfile() => UserAccountsDrawerHeader(

    // currentAccountPicture: GestureDetector(
    //   child:
    //  // Image.asset(logoImage),
    //
    //   const CircleAvatar(
    //     backgroundColor: Colors.black,
    //     backgroundImage: AssetImage(logoImage),
    //   ),
    // ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit:BoxFit.contain,
          image: AssetImage(logoImage),
        ),
        color: colorPrimary,
        shape: BoxShape.rectangle,
      ),

    accountName: Text("Username : "+name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),) ,
    accountEmail: Text('Asset Mangement System'),
  );

  Builder _buildLogoutButton() => Builder(
    builder: (context) =>
       ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Log out'),
        onTap: () => {
          AppData.setToken(""),
          Get.toNamed('/Login'),
        },
      ),

  );

  Builder _buildSettingButton() => Builder(
    builder: (context) => SafeArea(
      child: ListTile(
        leading: Icon(Icons.settings),
        title: Text('Setting'),
        //onTap: () => context.read<AuthBloc>().add(AuthEvent_Logout()),
      ),
    ),
  );


}

class CountListWidget extends StatelessWidget {
  final DashboardCountPlan dashboardCountPlan;

  const CountListWidget({
    Key? key,
    required this.dashboardCountPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int touchedIndex = -1;
    int countAll = dashboardCountPlan.data?.resultAll ?? 0;
    int countStatusOpen = dashboardCountPlan.data?.resultOpen ?? 0;
    int countStatusCounting = dashboardCountPlan.data?.resultCounting ?? 0;
    int countStatusClose = dashboardCountPlan.data?.resultClose ?? 0;


    List<PieChartSectionData> showingSections() {
      return List.generate(3, (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 20.0 : 15.0;
        final radius = isTouched ? 90.0 : 80.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
        var color3 = Colors.white;

        double valCountStatusOpen = (countStatusOpen/countAll) * 100;
        double valCountStatusCounting =(countStatusCounting/countAll) * 100;
        double valCountStatusClose = (countStatusClose/countAll) * 100;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: colorSuccess,
              value: valCountStatusOpen,
              title: '${NumberFormat('#,###').format(valCountStatusOpen)} %',
              radius: radius,
              titlePositionPercentageOffset: 0.55,
              titleStyle: TextStyle(
                fontSize: fontSize ,
                fontWeight: FontWeight.bold,
                color: color3,
                shadows: shadows,
              ),
            );
          case 1:
            return PieChartSectionData(
              color: colorInfo,
              value: valCountStatusCounting,
              title: '${NumberFormat('#,###').format(valCountStatusCounting)} %',
              radius: radius,
              titlePositionPercentageOffset: 0.55,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: color3,
                shadows: shadows,
              ),
            );
          case 2:
            return PieChartSectionData(
              color: colorWarning,
              value: valCountStatusClose,
              title: '${NumberFormat('#,###').format(valCountStatusClose)} %',
              radius: radius,
              titlePositionPercentageOffset: 0.55,
              titleStyle: TextStyle(
                fontSize: fontSize ,
                fontWeight: FontWeight.bold,
                color: color3,
                shadows: shadows,
              ),
            );
          default:
            throw Error();
        }
      });
    }

    return Container(
      child:
      Card(
        //color: colorDanger,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'PlAN COUNT',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(
                          height: 200,
                          child:   AspectRatio(
                            aspectRatio: 1,
                            child:PieChart(
                              PieChartData(
                                  pieTouchData:
                                  PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection == null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                  }),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 10,
                                  sections: showingSections()
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Indicator(
                              color: colorSuccess,
                              text: '${NumberFormat('#,###').format(countStatusOpen)} : OPEN',
                              isSquare: false,
                              size: touchedIndex == 0 ? 18 : 16,
                              // textColor: touchedIndex == 0
                              //     ? AppColors.mainTextColor1
                              //     : AppColors.mainTextColor3,
                            ),
                            Indicator(
                              color: colorInfo,
                              text: '${NumberFormat('#,###').format(countStatusCounting)} : COUNTING',
                              isSquare: false,
                              size: touchedIndex == 1 ? 18 : 16,
                              // textColor: touchedIndex == 1
                              //     ? AppColors.mainTextColor1
                              //     : AppColors.mainTextColor3,
                            ),
                            Indicator(
                              color: colorWarning,
                              text: '${NumberFormat('#,###').format(countStatusClose)} : CLOSE',
                              isSquare: false,
                              size: touchedIndex == 2 ? 18 : 16,
                              // textColor: touchedIndex == 2
                              //     ? AppColors.mainTextColor1
                              //     : AppColors.mainTextColor3,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 1),
                        ),
                      ],
                    )

                  ],
                ),

              ],
            )
        ),
      ),
      // ),
    );
  }



}

class Indicator extends StatelessWidget {
  const Indicator({
  super.key,
  required this.color,
  required this.text,
  required this.isSquare,
  this.size = 16,
  this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}