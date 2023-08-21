import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:ams_count/config/app_constants.dart';

import '../../../app.dart';
import '../../../data/models/serial_view_test/serial_view_test_response.dart';
import '../../../data/models/test_unit/serial_data_response.dart';
import '../../../data/models/test_unit/test_unit_request.dart';
import '../../../data/repositories/test_unit/test_unit_repository.dart';
import '../../../data/repositories/view_summary_unit/view_summary_unit_repository.dart';
import '../../../widgets/widget.dart';
import '../../test_unit/bloc/test_unit_bloc.dart';
import '../bloc/view_summary_unit_bloc.dart';

class ViewSummaryUnitPage extends StatefulWidget {
  const ViewSummaryUnitPage({Key? key}) : super(key: key);

  @override
  State<ViewSummaryUnitPage> createState() => _ViewSummaryUnitPageState();
}

class _ViewSummaryUnitPageState extends State<ViewSummaryUnitPage> {
  // final ViewType viewType;
  // _ViewSummaryUnitPageState({required this.viewType});

  late final ViewSummaryUnitRepository _repository;

  // TextEditingController connectionUrlController = TextEditingController();
  late TextEditingController txtProdNoController;
  late TextEditingController txtItemCodeController;
  late TextEditingController txtDescController;
  late TextEditingController txtSerialNoController;
  late TextEditingController txtQuantityController;
  late TextEditingController txtTotalQuantityController;

  late FocusNode serialFocusNode;

  var rows = List<PlutoRow>.empty(growable: true);

  late List<Serial> serialResult;
  late ViewTest viewTestResult;

  late List<String> listCheckSerial;

  @override
  void initState() {
    _repository = ViewSummaryUnitRepository();
    txtProdNoController = TextEditingController();
    txtItemCodeController = TextEditingController();
    txtDescController = TextEditingController();
    txtSerialNoController = TextEditingController();
    txtQuantityController = TextEditingController();
    txtTotalQuantityController = TextEditingController();

    serialFocusNode = FocusNode();
    Future.delayed(const Duration(milliseconds: 400)).then((value) => serialFocusNode.requestFocus());

    //init serial
    if (Get.arguments[0]['serialNo'] != null && Get.arguments[0]['serialNo'] != "") {
      txtSerialNoController.text = Get.arguments[0]['serialNo'];
    }

    //
    serialResult = []; // Serial();
    viewTestResult = ViewTest();
    listCheckSerial = [];

    super.initState();
  }

  @override
  void dispose() {
    // _repository.dispose();

    super.dispose();
  }

  void resetForm() {
    txtProdNoController.clear();
    txtItemCodeController.clear();
    txtDescController.clear();
    txtSerialNoController.clear();
    txtQuantityController.clear();
    txtTotalQuantityController.clear();

    serialFocusNode.requestFocus();
    setState(() {
      rows = List<PlutoRow>.empty(growable: true);

      //
      serialResult = []; //Serial();
      viewTestResult = ViewTest();
      listCheckSerial = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _repository,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 2.0,
          title: Text('Summary unit testing ${Get.arguments[0]['type'] == ViewType.offline ? '(Offline)' : ''}'),
        ),
        body: BlocProvider(
          create: (context) => ViewSummaryUnitBloc(repository: _repository)
            ..add(
              ViewSummaryUnitFetch(
                isOffline: Get.arguments[0]['type'] == ViewType.offline,
                serialNo: (Get.arguments[0]['serialNo'] != null && Get.arguments[0]['serialNo'] != "") ? Get.arguments[0]['serialNo'] : "",
              ),
            ),
          child: BlocConsumer<ViewSummaryUnitBloc, ViewSummaryUnitState>(
            listener: (context, state) {
              if (state.status == FetchStatus.fetching) {
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              } else {
                EasyLoading.dismiss();
              }

              if (state.status == FetchStatus.failed) {

                EasyLoading.showError('Get data failed!');
                resetForm();
              }

              if (state.status == FetchStatus.success) {
                setState(() {
                  rows = List<PlutoRow>.empty(growable: true);
                });

                if (state.items.isNotEmpty) {
                  var items = state.items;

                  txtTotalQuantityController.text = state.totalSerial.toString();

                  if (txtSerialNoController.text.isNotEmpty) {
                    var item = items.first;
                    txtProdNoController.text = item.prdOrderNo ?? "";
                    txtItemCodeController.text = item.itemcode ?? "";
                    txtDescController.text = item.description ?? "";
                    txtQuantityController.text = item.quantity == null ? "" : item.quantity.toString();
                  } else {
                    txtProdNoController.clear();
                    txtItemCodeController.clear();
                    txtDescController.clear();
                    txtQuantityController.clear();
                    // txtTotalQuantityController.clear();
                  }

                  setState(() {
                    viewTestResult = items.first;
                    if (state.serial != null) {
                      serialResult = state.serial!;
                    }

                    int rowNo = 1;
                    for (var element in items) {
                      rows.add(PlutoRow(cells: {
                        'no': PlutoCell(value: rowNo),
                        'check': PlutoCell(value: false),
                        'serial': PlutoCell(value: element.serialUnit),
                        'orderId': PlutoCell(value: element.orderId ?? ""),
                        'prodNo': PlutoCell(value: element.prdOrderNo),
                        'itemCode': PlutoCell(value: element.itemcode),
                        'desc': PlutoCell(value: element.description),
                        'quantity': PlutoCell(value: element.quantity),
                        'countSerial': PlutoCell(value: element.countSerial),
                        'time': PlutoCell(value: element.testPass),
                      }, checked: false));
                      rowNo++;
                    }
                  });
                } else {
                  EasyLoading.showError('No data found!');
                  resetForm();
                }
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    CustomInputField(
                      controller: txtSerialNoController,
                      focusNode: serialFocusNode,
                      labelText: 'Serial No. :',
                      showLabelFloatLeft: true,
                      inputType: InputType.number,
                      keyboardType:  TextInputType.number,
                      onChanged: (e) {},
                      onFieldSubmitted: (value) {
                        // print('val: $value');
                        context.read<ViewSummaryUnitBloc>().add(
                              ViewSummaryUnitFetch(
                                serialNo: value,
                                isOffline: Get.arguments[0]['type'] == ViewType.offline,
                              ),
                            );
                      },
                    ),
                    CustomInputField(
                      controller: txtProdNoController,
                      labelText: 'Prod No. :',
                      showLabelFloatLeft: true,
                      readOnly: true,
                      onChanged: (e) {},
                    ),
                    CustomInputField(
                      controller: txtItemCodeController,
                      labelText: 'Item Code :',
                      showLabelFloatLeft: true,
                      readOnly: true,
                      onChanged: (e) {},
                    ),
                    CustomInputField(
                      controller: txtDescController,
                      labelText: 'Description :',
                      maxLines: 4,
                      showLabelFloatLeft: true,
                      readOnly: true,
                      onChanged: (e) {},
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomInputField(
                            controller: txtQuantityController,
                            labelText: 'Quantity :',
                            showLabelFloatLeft: true,
                            readOnly: true,
                            onChanged: (e) {},
                          ),
                        ),

                      ],
                    ),
                    Get.arguments[0]['type'] == ViewType.offline
                        ? Row(
                            children: [
                              Expanded(
                                child: CustomInputField(
                                  controller: txtTotalQuantityController,
                                  labelText: 'All Qty :',
                                  showLabelFloatLeft: true,
                                  readOnly: true,
                                  onChanged: (e) {},
                                ),
                              ),
                              Get.arguments[0]['type'] == ViewType.offline
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: BlocProvider(
                                        create: (context) => TestUnitBloc(repository: TestUnitRepository()),
                                        child: BlocConsumer<TestUnitBloc, TestUnitState>(
                                          listener: (context, state) async {
                                            /// Send
                                            //   AlertConfirmDialog.alert(context: context, title: "Warning", description: 'Cannot delivery more than Issue Qty.', onPressed: () {});
                                            if (state.status == FetchStatus.sending) {
                                              EasyLoading.show(status: state.progress, maskType: EasyLoadingMaskType.black);
                                            } else {
                                              EasyLoading.dismiss();
                                            }

                                            if (state.status == FetchStatus.sendFailed) {
                                              setState(() {
                                                rows = List<PlutoRow>.empty(growable: true);
                                                serialResult = []; //Serial();
                                                viewTestResult = ViewTest();
                                                listCheckSerial = [];
                                              });
                                              AlertConfirmDialog.alert(
                                                  context: context,
                                                  title: "Failed",
                                                  widgetDescription: Text(
                                                    state.message,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                    //fetch
                                                    final bloc = BlocProvider.of<ViewSummaryUnitBloc>(context);
                                                    bloc.add(const ViewSummaryUnitFetch(serialNo: '', isOffline: true));
                                                  },
                                                  textConfirm: 'OK');
                                            }

                                            if (state.status == FetchStatus.sendSuccess) {
                                              setState(() {
                                                rows = List<PlutoRow>.empty(growable: true);
                                                serialResult = []; //Serial();
                                                viewTestResult = ViewTest();
                                                listCheckSerial = [];
                                              });
                                              await EasyLoading.showSuccess(state.progress ?? "Send complete").then((value) {
                                                //fetch
                                                context.read<ViewSummaryUnitBloc>().add(
                                                      const ViewSummaryUnitFetch(
                                                        serialNo: '',
                                                        isOffline: true,
                                                      ),
                                                    );
                                              });
                                            }
                                          },
                                          builder: (context, state) {
                                            return CustomButtonPrimary(
                                              text: 'Send',
                                              width: 100,
                                              padding: const EdgeInsets.symmetric(vertical: 14),
                                              onPress: () {
                                                if (serialResult.isNotEmpty) {
                                                  var serialSelect = rows.where((element) => element.cells['check']!.value == true).map((e) => e.cells['serial']!.value.toString()).toList();
                                                  if (serialSelect.isEmpty) {
                                                    EasyLoading.showError('Please select at least 1 serial.');
                                                    return;
                                                  }

                                                  var listData = serialResult
                                                      .where((element) => serialSelect.contains(element.serialUnit))
                                                      .map((r) => TestUnitData(
                                                            orderId: int.parse(r.orderId == null || r.orderId!.isEmpty ? "0" : r.orderId!),
                                                            prdOrderNo: r.prdOrderNo ?? "",
                                                            itemCode: r.itemcode ?? "",
                                                            serial: int.parse(r.serialUnit ?? "0"),
                                                            rL1L2: r.cL1L2 != null,
                                                            rL2L3: r.cL2L3 != null,
                                                            rL3L1: r.cL3L1 != null,
                                                            cL1L2: r.cL1L2.toString(),
                                                            cL2L3: r.cL2L3.toString(),
                                                            cL3L1: r.cL3L1.toString(),
                                                            hvTest: r.isHvTest,
                                                          ))
                                                      .toList();
                                                  context.read<TestUnitBloc>().add(FormOfflineSubmitted(sendSerial: listData));
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          )
                        : const SizedBox(),
                    buildGrid(),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
        floatingActionButton: Visibility(
          visible: rows.any((element) => element.checked!),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: BlocProvider(
              create: (context) => TestUnitBloc(repository: TestUnitRepository()),
              child: BlocConsumer<TestUnitBloc, TestUnitState>(
                listener: (context, state) {
                  if (state.status == FetchStatus.fetching) {
                    EasyLoading.show(maskType: EasyLoadingMaskType.black);
                  } else {
                    EasyLoading.dismiss();
                  }

                  if (state.status == FetchStatus.failed) {
                    EasyLoading.showError(state.message, duration: const Duration(seconds: 5));
                  }

                  if (state.status == FetchStatus.removeSuccess) {
                    EasyLoading.showSuccess('Delete complete');
                    resetForm();

                    //fetch
                    context.read<ViewSummaryUnitBloc>().add(
                          const ViewSummaryUnitFetch(
                            serialNo: '',
                            isOffline: true,
                          ),
                        );
                  }
                },
                builder: (context, state) {
                  return FloatingActionButton.extended(
                    onPressed: () {
                      var serials = rows.where((element) => element.cells['check']!.value == true).map((e) => e.cells['serial']!.value.toString()).toList();
                      context.read<TestUnitBloc>().add(TestUnitRemove(serials: serials));
                    },
                    backgroundColor: colorDanger,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildGrid() {
    PlutoGridStateManager? stateManager;

    final List<PlutoColumn> columns = <PlutoColumn>[
      PlutoColumn(
          title: '',
          field: 'check',
          type: PlutoColumnType.text(),
          width: 50,
          cellPadding: const EdgeInsets.symmetric(horizontal: 0),
          titlePadding: const EdgeInsets.symmetric(horizontal: 0),
          enableContextMenu: false,
          enableColumnDrag: false,
          enableSorting: false,
          enableRowDrag: false,
          enableDropToResize: false,
          enableRowChecked: true,
          hide: Get.arguments[0]['type'] != ViewType.offline),
      PlutoColumn(
        title: 'Serial Pass Testing',
        field: 'serial',
        type: PlutoColumnType.text(),
        width: 150,
        readOnly: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableDropToResize: false,
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Testing Time',
        field: 'time',
        type: PlutoColumnType.text(),
        width: 110,
        readOnly: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableDropToResize: false,
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Order ID',
        field: 'orderId',
        type: PlutoColumnType.text(),
        width: 90,
        readOnly: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableDropToResize: false,
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Prod No',
        field: 'prodNo',
        type: PlutoColumnType.text(),
        width: 100,
        readOnly: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableDropToResize: false,
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Item Code',
        field: 'itemCode',
        type: PlutoColumnType.text(),
        width: 150,
        readOnly: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableDropToResize: true,
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Description',
        field: 'desc',
        type: PlutoColumnType.text(),
        width: 150,
        readOnly: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableDropToResize: true,
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Quantity',
        field: 'quantity',
        type: PlutoColumnType.number(),
        width: 100,
        readOnly: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableDropToResize: false,
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Count Serial',
        field: 'countSerial',
        type: PlutoColumnType.number(),
        width: 130,
        readOnly: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableDropToResize: false,
        textAlign: PlutoColumnTextAlign.left,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),

    ];

    return SizedBox(
      height: Get.height > 540 ? Get.height - 430 : 420,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: PlutoGrid(
          key: UniqueKey(),
          columns: columns,
          rows: rows,
          mode: PlutoGridMode.select,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            event.stateManager.setSelectingMode(PlutoGridSelectingMode.horizontal);

            stateManager = event.stateManager;
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            if (kDebugMode) {
              // print(event);
              print('CHANGED');
            }
          },
          onSelected: (PlutoGridOnSelectedEvent event) async {
            if (kDebugMode) {
              print(event);
            }
          },
          onRowSecondaryTap: (PlutoGridOnRowSecondaryTapEvent e) {
            if (kDebugMode) {
              print(e);
              print('SecondaryTapEvent');
            }
          },
          onRowChecked: (PlutoGridOnRowCheckedEvent e) {
            if (e.isAll) {
              if (kDebugMode) {
                print('CHECKED ALL');
              }
              setState(() {
                for (var row in rows) {
                  row.cells['check']!.value = e.isChecked!;
                }
              });
            } else {
              var eRow = e.row!;
              if (kDebugMode) {
                print('CHECKED');
                print(eRow.cells['serial']!.value);
              }
              var row = rows.firstWhereOrNull((element) => element.cells['serial'] == eRow.cells['serial']);
              if (row != null) {
                setState(() {
                  row.cells['check']!.value = eRow.checked!;
                });
              }
            }
          },
          configuration: const PlutoGridConfiguration(
            // enableColumnBorder: true,
            // gridBorderColor: Colors.black12,
            style: PlutoGridStyleConfig(
              evenRowColor: Color.fromRGBO(224, 240, 255, 0.5),
              oddRowColor: Color.fromRGBO(166, 205, 255, .5),
            ),
            enableMoveHorizontalInEditing: false,
          ),
          createFooter: (stateManager) {
            stateManager.setPageSize(100, notify: false); // default 40
            return PlutoPagination(stateManager);
          },
        ),
      ),
    );
  }
}
