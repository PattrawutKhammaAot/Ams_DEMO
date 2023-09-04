import 'dart:async';

import 'package:ams_count/blocs/asset/assets_bloc.dart';
import 'package:ams_count/models/dashboard/dashboardAssetStatusModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../blocs/count/count_bloc.dart';
import '../../../blocs/home/bloc/home_bloc.dart';
import '../../../blocs/report/report_bloc.dart';
import '../../../config/api_path.dart';
import '../../../config/app_constants.dart';
import '../../../config/app_data.dart';
import '../../../data/database/dbsqlite.dart';
import '../../../data/models/dashboard/DashboardCountPlan.dart';
import '../../../models/count/responeModel.dart';
import '../../../models/master/statusAssetCountModel.dart';
import '../../../widgets/custom_card_menu.dart';
import '../../../widgets/custom_range_pointer.dart';
import '../../../widgets/label.dart';

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
  ResponseModel itemCheckAll = ResponseModel();
  ResponseModel itemCheck = ResponseModel();
  ResponseModel itemUncheck = ResponseModel();
  Data dashBoardCountPlan = Data();
  DashBoardAssetStatusModel itemStatusDashboard = DashBoardAssetStatusModel();
  String? mode;
  List<String> images = [
    "assets/images/bg_mainMenu2.jpg",
    "assets/images/bg_mainMenu1.jpg",
  ];
  Timer? time;
  int currentImage = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    appVersion = "";
    getAppInfo();
    initial();
    touchedIndex = -1;
    context.read<HomeBloc>().add(HomeEvent_LoadCountDashboard());
    BlocProvider.of<CountBloc>(context).add(const GetLocationEvent());
    BlocProvider.of<CountBloc>(context).add(const GetDepartmentEvent());
    BlocProvider.of<CountBloc>(context).add(const GetStatusAssetsCountEvent());
    BlocProvider.of<CountBloc>(context).add(const GetListCountPlanEvent());
    BlocProvider.of<CountBloc>(context).add(const CheckAllTotalEvent());
    BlocProvider.of<CountBloc>(context).add(const CheckTotalEvent());
    BlocProvider.of<CountBloc>(context).add(const CheckUncheckEvent());
    BlocProvider.of<ReportBloc>(context)
        .add(GetListCountDetailForReportEvent(""));
    BlocProvider.of<AssetsBloc>(context)
        .add(const GetDashBoardAssetStatusEvent());
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      autoChangeImage();
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initial() async {
    String _username = await AppData.getUserName();
    setState(() {
      name = _username;
    });
  }

  void autoChangeImage() {
    final currentPage = _pageController.page ?? 0;
    final nextPage = currentPage + 1;

    if (nextPage < images.length) {
      _pageController.animateToPage(
        nextPage.toInt(),
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    } else {
      _pageController.animateToPage(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
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
    return MultiBlocListener(
      listeners: [
        BlocListener<AssetsBloc, AssetsState>(listener: (context, state) async {
          if (state is GetDashBoardAssetStatusLoadedState) {
            setState(() {
              itemStatusDashboard = state.item;
            });
            await AppData.setApiUrl(apiUrl);
          } else if (state is GetDashBoardAssetStatusErrorState) {
            printInfo(info: "Test print Error");
            var itemSql = await DashBoardAssetStatusModel().query();
            for (var item in itemSql) {
              itemStatusDashboard.RESULT_ALL = item[DashboardField.RESULT_ALL];
              itemStatusDashboard.RESULT_NORMAL =
                  item[DashboardField.RESULT_NORMAL];
              itemStatusDashboard.RESULT_REPAIR =
                  item[DashboardField.RESULT_REPAIR];
              itemStatusDashboard.RESULT_BORROW =
                  item[DashboardField.RESULT_BORROW];
              itemStatusDashboard.RESULT_SALE =
                  item[DashboardField.RESULT_SALE];
              itemStatusDashboard.RESULT_WRITEOFF =
                  item[DashboardField.RESULT_WRITEOFF];
            }
            setState(() {});
          }
        }),
        BlocListener<HomeBloc, HomeState>(listener: (context, state) async {
          if (state is HomeLoaded) {
            dashBoardCountPlan = state.dashboardCountPlan.data!;
            setState(() {});
          } else {
            var itemSql = await Data().query();
            printInfo(info: "test${itemSql[0]['resultAll']}");
            dashBoardCountPlan = Data.fromJson(itemSql.first);
            // dashBoardCountPlan = itemSql.map((e) => Data.fromJson(e));
          }
        })
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: colorPrimary.withOpacity(0.5),
          elevation: 0,
          titleTextStyle: const TextStyle(fontSize: 24.0),
          centerTitle: true,
          title: const Text(
            'Asset Mangement System',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        drawer: CustomDrawer(name: name),
        body: RefreshIndicator(
          onRefresh: () async =>
              context.read<HomeBloc>().add(HomeEvent_LoadCountDashboard()),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                              physics: const BouncingScrollPhysics(),
                              padEnds: false,
                              itemCount: images.length,
                              pageSnapping: true,
                              onPageChanged: (i) {},
                              controller: _pageController,
                              itemBuilder: (context, pagePosition) {
                                return Container(
                                    child: Image.asset(
                                  images[pagePosition],
                                  fit: BoxFit.fill,
                                ));
                              }))),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(child: SizedBox()),
                        Center(
                          child: Wrap(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CountListWidget(
                                    dashboardCountPlan: dashBoardCountPlan,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        itemStatusDashboard.RESULT_ALL != null
                            ? Expanded(
                                flex: 2,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: _DashBoardStatusBottom()),
                              )
                            : CircularProgressIndicator(),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ))
                ],
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    margin: const EdgeInsets.all(0),
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 10,
                      shape: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: colorPrimary.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(6)),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              children: [
                                CustomCardMenu(
                                    backgroundColor: Colors.transparent,
                                    text: "My Assets",
                                    pathImage: "iconAssets.png",
                                    onTap: () => Get.toNamed('/MyassetsPage')),
                                CustomCardMenu(
                                    backgroundColor: Colors.transparent,
                                    text: "Count",
                                    pathImage: "count.png",
                                    onTap: () async {
                                      await AppData.setApiUrl(apiUrl);
                                      Get.toNamed('/CountPage');
                                    }),
                                CustomCardMenu(
                                    backgroundColor: Colors.transparent,
                                    text: "Gallery",
                                    pathImage: "gallery.png",
                                    onTap: () => Get.toNamed('/GalleryPage')),
                                CustomCardMenu(
                                    backgroundColor: Colors.transparent,
                                    text: "Report",
                                    pathImage: "iconreport.png",
                                    onTap: () => Get.toNamed('/ReportPage')),
                                CustomCardMenu(
                                    backgroundColor: Colors.transparent,
                                    text: "Transfer",
                                    pathImage: "icontransfer.png",
                                    onTap: () => Get.toNamed('/TransferPage')),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _DashBoardStatusBottom() {
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          width: 250,
          child: Card(
            elevation: 0,
            color: colorInfo.withOpacity(0.5),
            shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12)),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Label(
                        "Result All",
                        color: colorPrimary,
                        fontWeight: FontWeight.bold,
                      )),
                      Expanded(
                        child: CustomRangePoint(
                          color: colorActive,
                          valueRangePointer: itemStatusDashboard.RESULT_ALL,
                          allItem: itemStatusDashboard.RESULT_ALL,
                          text: "",
                          colorText: colorPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 250,
          child: Card(
            elevation: 0,
            color: Colors.amberAccent.withOpacity(0.2),
            shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Label(
                    "Result Normal",
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                  )),
                  Expanded(
                    child: CustomRangePoint(
                      color: colorActive,
                      valueRangePointer: itemStatusDashboard.RESULT_NORMAL,
                      allItem: itemStatusDashboard.RESULT_ALL,
                      text: "",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 250,
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: OutlineInputBorder(
                borderSide: const BorderSide(color: colorPrimary),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Label(
                    "Result Repair",
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                  )),
                  Expanded(
                    child: CustomRangePoint(
                      color: colorActive,
                      valueRangePointer: itemStatusDashboard.RESULT_REPAIR,
                      allItem: itemStatusDashboard.RESULT_ALL,
                      text: "",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 250,
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: OutlineInputBorder(
                borderSide: const BorderSide(color: colorPrimary),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Label(
                    "Result Borrow",
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                  )),
                  Expanded(
                    child: CustomRangePoint(
                      color: colorActive,
                      valueRangePointer: itemStatusDashboard.RESULT_BORROW,
                      allItem: itemStatusDashboard.RESULT_ALL,
                      text: "",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 250,
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: OutlineInputBorder(
                borderSide: const BorderSide(color: colorPrimary),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Label(
                    "Result Sale",
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                  )),
                  Expanded(
                    child: CustomRangePoint(
                      color: colorActive,
                      valueRangePointer: itemStatusDashboard.RESULT_SALE,
                      allItem: itemStatusDashboard.RESULT_ALL,
                      text: "",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 250,
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: OutlineInputBorder(
                borderSide: const BorderSide(color: colorPrimary),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Label(
                    "Result WriteOff",
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                  )),
                  Expanded(
                    child: CustomRangePoint(
                      color: colorActive,
                      valueRangePointer: itemStatusDashboard.RESULT_WRITEOFF,
                      allItem: itemStatusDashboard.RESULT_ALL,
                      text: "",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({required this.name, Key? key}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfile(),
          const ListTile(
            leading: Icon(
              Icons.dashboard,
              color: Colors.red,
            ),
            title: Text("Dashboard"),
            //onTap: () => _showMyDialog(context),
          ),
          const ListTile(
            //onTap: () => _PickFile(context),
            title: Text("Import"),
            leading: Icon(Icons.import_contacts, color: Colors.deepOrange),
          ),
          const ListTile(
            //onTap: () => _showDialogQRImage(context),
            title: Text("Count"),
            leading: Icon(Icons.qr_code_scanner, color: Colors.green),
          ),
          const ListTile(
            //onTap: () => _showScanQRCode(context),
            title: Text("Gallery"),
            leading: Icon(Icons.photo_library, color: Colors.lightBlue),
          ),
          const ListTile(
            //onTap: () => Navigator.pushNamed(context, AppRoute.map),
            title: Text("Export"),
            leading: Icon(Icons.import_export, color: Colors.amber),
          ),
          const Spacer(),
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(logoImage),
          ),
          color: colorPrimary,
          shape: BoxShape.rectangle,
        ),

        accountName: Text(
          "Username : " + name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        accountEmail: const Text('Asset Mangement System'),
      );

  Builder _buildLogoutButton() => Builder(
        builder: (context) => ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Log out'),
          onTap: () => {
            AppData.setToken(""),
            Get.toNamed('/Login'),
          },
        ),
      );

  Builder _buildSettingButton() => Builder(
        builder: (context) => const SafeArea(
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting'),
            //onTap: () => context.read<AuthBloc>().add(AuthEvent_Logout()),
          ),
        ),
      );
}

class CountListWidget extends StatelessWidget {
  final Data dashboardCountPlan;

  const CountListWidget({
    Key? key,
    required this.dashboardCountPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int touchedIndex = -1;
    int countAll = dashboardCountPlan.resultAll ?? 10;
    int countStatusOpen = dashboardCountPlan.resultOpen ?? 2;
    int countStatusCounting = dashboardCountPlan.resultCounting ?? 2;
    int countStatusClose = dashboardCountPlan.resultClose ?? 6;

    List<PieChartSectionData> showingSections() {
      return List.generate(3, (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 20.0 : 15.0;
        final radius = isTouched ? 60.0 : 65.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
        var color3 = Colors.white;

        double valCountStatusOpen = (countStatusOpen / countAll) * 100;
        double valCountStatusCounting = (countStatusCounting / countAll) * 100;
        double valCountStatusClose = (countStatusClose / countAll) * 100;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: colorSuccess,
              value: valCountStatusOpen,
              title: '${NumberFormat('#,###').format(valCountStatusOpen)} %',
              radius: radius,
              titlePositionPercentageOffset: 0.55,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: color3,
                shadows: shadows,
              ),
            );
          case 1:
            return PieChartSectionData(
              color: colorInfo,
              value: valCountStatusCounting,
              title:
                  '${NumberFormat('#,###').format(valCountStatusCounting)} %',
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
                fontSize: fontSize,
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
      child: Card(
        color: Colors.white,
        elevation: 10,
        shape: OutlineInputBorder(
          borderSide: BorderSide(color: colorPrimary.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'PLAN COUNT',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorPrimary),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          left: 5, right: 15, top: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Indicator(
                                  color: colorSuccess,
                                  text:
                                      'OPEN: ${NumberFormat('#,###').format(countStatusOpen)} ',
                                  isSquare: false,
                                  size: touchedIndex == 0 ? 18 : 16,
                                  textColor: colorPrimary,
                                  // textColor: touchedIndex == 0
                                  //     ? AppColors.mainTextColor1
                                  //     : AppColors.mainTextColor3,
                                ),
                                Indicator(
                                  color: colorInfo,
                                  text:
                                      'COUNTING: ${NumberFormat('#,###').format(countStatusCounting)} ',
                                  isSquare: false,
                                  size: touchedIndex == 1 ? 18 : 16,
                                  textColor: colorPrimary,
                                  // textColor: touchedIndex == 1
                                  //     ? AppColors.mainTextColor1
                                  //     : AppColors.mainTextColor3,
                                ),
                                Indicator(
                                  color: colorWarning,
                                  text:
                                      'CLOSE: ${NumberFormat('#,###').format(countStatusClose)}',
                                  isSquare: false,
                                  size: touchedIndex == 2 ? 18 : 16,
                                  textColor: colorPrimary,
                                  // textColor: touchedIndex == 2
                                  //     ? AppColors.mainTextColor1
                                  //     : AppColors.mainTextColor3,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(right: 50, bottom: 5),
                            height: 50,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: PieChart(
                                PieChartData(
                                    pieTouchData: PieTouchData(touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                    }),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 3,
                                    centerSpaceRadius: 10,
                                    sections: showingSections()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            )),
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
