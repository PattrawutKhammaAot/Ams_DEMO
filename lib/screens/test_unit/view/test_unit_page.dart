// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:ams_count/config/app_constants.dart';

// import '../../../app.dart';
// import '../../../data/models/test_unit/serial_data_response.dart';
// import '../../../data/models/test_unit/test_unit_request.dart';
// import '../../../data/repositories/test_unit/test_unit_repository.dart';
// import '../../../widgets/widget.dart';
// import '../bloc/test_unit_bloc.dart';

// class TestUnitPage extends StatefulWidget {
//   const TestUnitPage({Key? key}) : super(key: key);

//   @override
//   State<TestUnitPage> createState() => _TestUnitPageState();
// }

// class _TestUnitPageState extends State<TestUnitPage> {
//   late final TestUnitRepository _repository;

//   late TextEditingController txtProdNoController;
//   late TextEditingController txtItemCodeController;
//   late TextEditingController txtDescController;
//   late TextEditingController txtSerialNoController;
//   late TextEditingController txtResistanceMinController;
//   late TextEditingController txtResistanceMaxController;
//   late TextEditingController txtCapacitanceMinController;
//   late TextEditingController txtCapacitanceMaxController;
//   late TextEditingController txtInputCapacitance1Controller;
//   late TextEditingController txtInputCapacitance2Controller;
//   late TextEditingController txtInputCapacitance3Controller;
//   late TextEditingController txtHvTestController;

//   late FocusNode serialFocusNode;
//   late FocusNode capacitance1FocusNode;
//   late FocusNode capacitance2FocusNode;
//   late FocusNode capacitance3FocusNode;

//   late bool capacitance1Checked;
//   late bool capacitance2Checked;
//   late bool capacitance3Checked;
//   late bool hvTestChecked;
//   late bool offlineChecked;

//   late List<Serial> serials;
//   late Serial currentSerial;
//   late int currentSerialIndex;

//   late bool sendValid;

//   double maxCapacitance = 4100;

//   @override
//   void initState() {
//     _repository = TestUnitRepository();

//     txtProdNoController = TextEditingController();
//     txtItemCodeController = TextEditingController();
//     txtDescController = TextEditingController();
//     txtSerialNoController = TextEditingController();
//     txtResistanceMinController = TextEditingController();
//     txtResistanceMaxController = TextEditingController();
//     txtCapacitanceMinController = TextEditingController();
//     txtCapacitanceMaxController = TextEditingController();
//     txtInputCapacitance1Controller = TextEditingController();
//     txtInputCapacitance2Controller = TextEditingController();
//     txtInputCapacitance3Controller = TextEditingController();
//     txtHvTestController = TextEditingController();

//     capacitance1Checked = false;
//     capacitance2Checked = false;
//     capacitance3Checked = false;
//     hvTestChecked = false;
//     offlineChecked = false;

//     serialFocusNode = FocusNode();
//     capacitance1FocusNode = FocusNode();
//     capacitance2FocusNode = FocusNode();
//     capacitance3FocusNode = FocusNode();
//     Future.delayed(const Duration(milliseconds: 400)).then((value) => serialFocusNode.requestFocus());

//     serials = [];
//     currentSerial = Serial();
//     currentSerialIndex = 0;

//     sendValid = false;

//     super.initState();
//   }

//   @override
//   void dispose() {
//     txtProdNoController.dispose();
//     txtItemCodeController.dispose();
//     txtDescController.dispose();
//     txtSerialNoController.dispose();
//     txtResistanceMinController.dispose();
//     txtResistanceMaxController.dispose();
//     txtCapacitanceMinController.dispose();
//     txtCapacitanceMaxController.dispose();
//     txtInputCapacitance1Controller.dispose();
//     txtInputCapacitance2Controller.dispose();
//     txtInputCapacitance3Controller.dispose();
//     txtHvTestController.dispose();

//     super.dispose();
//   }

//   void resetControl() {
//     txtProdNoController.clear();
//     txtItemCodeController.clear();
//     txtDescController.clear();
//     txtSerialNoController.clear();
//     txtResistanceMinController.clear();
//     txtResistanceMaxController.clear();
//     txtCapacitanceMinController.clear();
//     txtCapacitanceMaxController.clear();
//     txtInputCapacitance1Controller.clear();
//     txtInputCapacitance2Controller.clear();
//     txtInputCapacitance3Controller.clear();
//     txtHvTestController.clear();

//     setState(() {
//       capacitance1Checked = false;
//       capacitance2Checked = false;
//       capacitance3Checked = false;
//       hvTestChecked = false;
//       // offlineChecked = false;

//       serials = [];
//       currentSerial = Serial();
//       currentSerialIndex = 0;

//       sendValid = false;
//     });
//   }

//   bool validateCapacitance(double min, double max, double input) {
//     if (input >= min && input < max) {
//       return true;
//     } else {
//       EasyLoading.showError('Input between Min and Max!', duration: const Duration(seconds: 5));
//       return false;
//     }
//   }

//   void validateSend() {
//     setState(() {
//       sendValid = (txtSerialNoController.text.isNotEmpty &&
//           (offlineChecked || txtItemCodeController.text.isNotEmpty) &&
//           txtInputCapacitance1Controller.text.isNotEmpty &&
//           txtInputCapacitance2Controller.text.isNotEmpty &&
//           txtInputCapacitance3Controller.text.isNotEmpty &&
//           hvTestChecked);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(
//       value: _repository,
//       child: BlocProvider(
//         create: (context) => TestUnitBloc(repository: _repository),
//         child: Scaffold(
//           appBar: AppBar(
//             elevation: 2.0,
//             // title: const Text('Record measurement of unit test'),
//             title: const Text('Test Unit'),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: 36,
//                     child: offlineChecked
//                         ? const BlinkingIconStatus(
//                             icon: Icons.error_rounded,
//                             color: colorDanger,
//                             size: 32,
//                           )
//                         :
//                         //const Icon(Icons.error_rounded, color: colorDanger) :
//                         //const BlinkingIconStatus(icon: Icons.cloud_circle, color: colorSuccess),
//                         const Icon(
//                             Icons.cloud_circle,
//                             color: colorSuccess,
//                             size: 32,
//                           ),

//                     // CustomCheckBoxField(
//                     //   value: offlineChecked,
//                     //   color: colorDanger,
//                     //   onChanged: (bool value) {
//                     //     if (kDebugMode) {
//                     //       print('CHECK: $value');
//                     //     }
//                     //     setState(() {
//                     //       offlineChecked = value;
//                     //     });
//                     //     checkBoxOffline(context, value);
//                     //   },
//                     // ),
//                   ),
//                   Text(offlineChecked ? 'Offline' : 'Online'),
//                   const SizedBox(width: 16)
//                 ],
//               ),
//               // BlocBuilder<TestUnitBloc, TestUnitState>(
//               //   builder: (context, state) {
//               //     return Row(
//               //       mainAxisAlignment: MainAxisAlignment.start,
//               //       children: [
//               //         SizedBox(
//               //           width: 36,
//               //           child: CustomCheckBoxField(
//               //             value: offlineChecked,
//               //             color: colorDanger,
//               //             onChanged: (bool value) {
//               //               if (kDebugMode) {
//               //                 print('CHECK: $value');
//               //               }
//               //               setState(() {
//               //                 offlineChecked = value;
//               //               });
//               //               checkBoxOffline(context, value);
//               //             },
//               //           ),
//               //         ),
//               //         GestureDetector(
//               //             onTap: () {
//               //               setState(() {
//               //                 offlineChecked = !offlineChecked;
//               //               });
//               //               checkBoxOffline(context, offlineChecked);
//               //             },
//               //             child: const Text('Offline')),
//               //         const SizedBox(
//               //           width: 16,
//               //         )
//               //       ],
//               //     );
//               //   },
//               // ),
//             ],
//           ),
//           body: BlocConsumer<TestUnitBloc, TestUnitState>(
//             listener: (context, state) {
//               if (state.status == FetchStatus.fetching) {
//                 EasyLoading.show(maskType: EasyLoadingMaskType.black);
//               } else {
//                 EasyLoading.dismiss();
//               }

//               if (state.status == FetchStatus.failed) {
//                 EasyLoading.showError(state.message, duration: const Duration(seconds: 5));
//                 serialFocusNode.requestFocus();
//               }

//               if (state.status == FetchStatus.connectionFailed) {
//                 setState(() {
//                   offlineChecked = true;
//                 });

//                 if (!offlineChecked) {
//                   EasyLoading.showError(state.message, duration: const Duration(seconds: 5));
//                   //serialFocusNode.requestFocus();
//                 }
//                 capacitance1FocusNode.requestFocus();
//               }

//               if (state.status == FetchStatus.removeSuccess) {
//                 EasyLoading.showSuccess('Clear data complete');
//               }

//               /// Get data success
//               if (state.status == FetchStatus.success) {
//                 resetControl();
//                 // setState(() {
//                 //   rows = List<PlutoRow>.empty(growable: true);
//                 // });

//                 setState(() {
//                   serials = state.serials;
//                   currentSerial = serials.first;
//                   currentSerialIndex = 0;
//                   sendValid = false;

//                   // Set to online
//                   offlineChecked = false;
//                 });
//                 var item = serials.first;

//                 txtProdNoController.text = item.prdOrderNo ?? "";
//                 txtItemCodeController.text = item.itemcode ?? "";
//                 txtDescController.text = item.description ?? "";
//                 txtSerialNoController.text = item.serialUnit ?? "";
//                 txtResistanceMinController.text = item.rMin != null ? item.rMin.toString() : "";
//                 txtResistanceMaxController.text = item.rMax != null ? item.rMax.toString() : "";
//                 txtCapacitanceMinController.text = item.cuF0 != null ? item.cuF0.toString() : "";
//                 txtCapacitanceMaxController.text = item.cuF10 != null ? item.cuF10.toString() : "";
//                 // txtInputCapacitance1Controller.clear();
//                 // txtInputCapacitance2Controller.text =  "";
//                 // txtInputCapacitance3Controller.text =  "";
//                 // txtHvTestController.text = item.prdOrderNo ?? "";

//                 // setState(() {
//                 //   int rowNo = 1;
//                 //   for (var element in items) {
//                 //     rows.add(PlutoRow(
//                 //       cells: {
//                 //         'no': PlutoCell(value: rowNo),
//                 //         'serial': PlutoCell(value: element.serialUnit),
//                 //         'time': PlutoCell(value: element.testPass),
//                 //       },
//                 //     ));
//                 //     rowNo++;
//                 //   }
//                 // });
//               }

//               /// Send Success
//               if (state.status == FetchStatus.sendSuccess) {
//                 // Check serial in list
//                 // setState(() {
//                 //   currentSerial.isSend = true;
//                 //   currentSerialIndex = currentSerialIndex + 1;
//                 // });
//                 //
//                 // if(serials.length < currentSerialIndex ){
//                 //   // Send all serial success
//                 //   setState(() {
//                 //     sendValid = true;
//                 //   });
//                 // }else{
//                 //
//                 // }
//                 // If this serial is success "Disable Send Button"

//                 EasyLoading.showSuccess("Send complete", duration: const Duration(seconds: 5));

//                 resetControl();
//                 serialFocusNode.requestFocus();
//               }

//               /// Save Offline
//               if (state.status == FetchStatus.saved) {
//                 EasyLoading.showSuccess("Save complete", duration: const Duration(seconds: 5));

//                 resetControl();
//                 serialFocusNode.requestFocus();
//               }
//             },
//             builder: (context, state) {
//               return SingleChildScrollView(
//                 keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//                 child: Column(
//                   children: [
//                     CustomInputField(
//                       controller: txtProdNoController,
//                       labelText: 'Prod No. :',
//                       showLabelFloatLeft: true,
//                       readOnly: true,
//                       onChanged: (e) {
//                         // context.read<ConnectionSettingBloc>().add(C)
//                       },
//                     ),
//                     CustomInputField(
//                       controller: txtItemCodeController,
//                       labelText: 'Item Code :',
//                       showLabelFloatLeft: true,
//                       readOnly: true,
//                       onChanged: (e) {
//                         // context.read<ConnectionSettingBloc>().add(C)
//                       },
//                     ),
//                     CustomInputField(
//                       controller: txtDescController,
//                       labelText: 'Description :',
//                       maxLines: 4,
//                       showLabelFloatLeft: true,
//                       readOnly: true,
//                       onChanged: (e) {
//                         // context.read<ConnectionSettingBloc>().add(C)
//                       },
//                     ),
//                     CustomInputField(
//                       controller: txtSerialNoController,
//                       focusNode: serialFocusNode,
//                       labelText: 'Serial No. :',
//                       showLabelFloatLeft: true,
//                       inputType: InputType.number,
//                       maxLength: 7,
//                       keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
//                       onChanged: (e) {
//                         // context.read<ConnectionSettingBloc>().add(C)
//                       },
//                       onFieldSubmitted: (value) {
//                         if (value.isNotEmpty && value.trim().length == 7) {
//                           // if (offlineChecked) {
//                           //   // Offline
//                           //   capacitance1FocusNode.requestFocus();
//                           //   setState(() {
//                           //     capacitance1Checked = true;
//                           //   });
//                           // } else {
//                           context.read<TestUnitBloc>().add(TestUnitFetch(serialNo: value.trim()));
//                           //}
//                         }
//                       },
//                     ),
//                     const SizedBox(height: 10),
//                     const Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: SizedBox(),
//                         ),
//                         Expanded(
//                             flex: 2,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Center(child: Text('Min', style: TextStyle(fontWeight: FontWeight.bold))),
//                                 ),
//                                 Expanded(
//                                   child: Center(child: Text('Max', style: TextStyle(fontWeight: FontWeight.bold))),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                             flex: 1,
//                             child: Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(right: 8.0, top: 12),
//                                   child: Text("Resistance :"),
//                                 ))),
//                         Expanded(
//                             flex: 2,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: CustomInputField(
//                                     controller: txtResistanceMinController,
//                                     readOnly: true,
//                                     onChanged: (e) {
//                                       // context.read<ConnectionSettingBloc>().add(C)
//                                     },
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: CustomInputField(
//                                     controller: txtResistanceMaxController,
//                                     readOnly: true,
//                                     onChanged: (e) {
//                                       // context.read<ConnectionSettingBloc>().add(C)
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),
//                     // const SizedBox(height: 10),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                             flex: 1,
//                             child: Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(right: 8.0, top: 12),
//                                   child: Text("Capacitance :"),
//                                 ))),
//                         Expanded(
//                             flex: 2,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: CustomInputField(
//                                     controller: txtCapacitanceMinController,
//                                     readOnly: true,
//                                     onChanged: (e) {
//                                       // context.read<ConnectionSettingBloc>().add(C)
//                                     },
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: CustomInputField(
//                                     controller: txtCapacitanceMaxController,
//                                     readOnly: true,
//                                     onChanged: (e) {
//                                       // context.read<ConnectionSettingBloc>().add(C)
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     const Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: SizedBox(),
//                         ),
//                         Expanded(
//                             flex: 2,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Center(child: Text('L1-L2', style: TextStyle(fontWeight: FontWeight.bold))),
//                                 ),
//                                 Expanded(
//                                   child: Center(child: Text('L2-L3', style: TextStyle(fontWeight: FontWeight.bold))),
//                                 ),
//                                 Expanded(
//                                   child: Center(child: Text('L3-L1', style: TextStyle(fontWeight: FontWeight.bold))),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                             flex: 1,
//                             child: Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(right: 8.0, top: 12),
//                                   child: Text("Resistance :"),
//                                 ))),
//                         Expanded(
//                             flex: 2,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: CustomCheckBoxField(
//                                     value: capacitance1Checked,
//                                     onChanged: (bool value) {
//                                       if (kDebugMode) {
//                                         print('CHECK 1: $value');
//                                       }
//                                       setState(() {
//                                         capacitance1Checked = value;
//                                       });
//                                       if (!capacitance1Checked) {
//                                         txtInputCapacitance1Controller.clear();
//                                       } else {
//                                         capacitance1FocusNode.requestFocus();
//                                       }
//                                       validateSend();
//                                     },
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: CustomCheckBoxField(
//                                     value: capacitance2Checked,
//                                     onChanged: (bool value) {
//                                       if (kDebugMode) {
//                                         print('CHECK: $value');
//                                       }
//                                       setState(() {
//                                         capacitance2Checked = value;
//                                       });
//                                       if (!capacitance2Checked) {
//                                         txtInputCapacitance2Controller.clear();
//                                       } else {
//                                         capacitance2FocusNode.requestFocus();
//                                       }
//                                       validateSend();
//                                     },
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: CustomCheckBoxField(
//                                     value: capacitance3Checked,
//                                     onChanged: (bool value) {
//                                       if (kDebugMode) {
//                                         print('CHECK: $value');
//                                       }
//                                       setState(() {
//                                         capacitance3Checked = value;
//                                       });
//                                       if (!capacitance3Checked) {
//                                         txtInputCapacitance3Controller.clear();
//                                       } else {
//                                         capacitance3FocusNode.requestFocus();
//                                       }
//                                       validateSend();
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                             flex: 1,
//                             child: Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(right: 8.0, top: 12),
//                                   child: Text("Capacitance :"),
//                                 ))),
//                         Expanded(
//                             flex: 2,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: CustomInputField(
//                                     controller: txtInputCapacitance1Controller,
//                                     focusNode: capacitance1FocusNode,
//                                     readOnly: !capacitance1Checked,
//                                     keyboardType: TextInputType.number,
//                                     onChanged: (e) {
//                                       // context.read<ConnectionSettingBloc>().add(C)
//                                       if (kDebugMode) {
//                                         print(e);
//                                       }
//                                       validateSend();
//                                     },
//                                     // onFieldSubmitted: (value) {
//                                     //   try {
//                                     //     if (!validateCapacitance(currentSerial.cuF0 ?? 0, currentSerial.cuF10 ?? 0, double.parse(value))) {
//                                     //       txtInputCapacitance1Controller.clear();
//                                     //       capacitance1FocusNode.requestFocus();
//                                     //     }
//                                     //   } catch (e) {
//                                     //     EasyLoading.showError('Invalid input data');
//                                     //   }
//                                     // },
//                                     onEditingComplete: () {
//                                       try {
//                                         if (!validateCapacitance(
//                                           txtCapacitanceMinController.text.isNotEmpty ? currentSerial.cuF0! : 0,
//                                           txtCapacitanceMaxController.text.isNotEmpty ? currentSerial.cuF10! : maxCapacitance,
//                                           double.parse(txtInputCapacitance1Controller.text),
//                                         )) {
//                                           txtInputCapacitance1Controller.clear();
//                                           capacitance1FocusNode.requestFocus();
//                                         } else {
//                                           capacitance1FocusNode.nextFocus();
//                                         }
//                                       } catch (e) {
//                                         EasyLoading.showError('Invalid input data');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: CustomInputField(
//                                     controller: txtInputCapacitance2Controller,
//                                     focusNode: capacitance2FocusNode,
//                                     readOnly: !capacitance2Checked,
//                                     keyboardType: TextInputType.number,
//                                     onChanged: (e) {
//                                       // context.read<ConnectionSettingBloc>().add(C)
//                                       validateSend();
//                                     },
//                                     onEditingComplete: () {
//                                       try {
//                                         if (!validateCapacitance(
//                                           txtCapacitanceMinController.text.isNotEmpty ? currentSerial.cuF0! : 0,
//                                           txtCapacitanceMaxController.text.isNotEmpty ? currentSerial.cuF10! : maxCapacitance,
//                                           double.parse(txtInputCapacitance2Controller.text),
//                                         )) {
//                                           txtInputCapacitance2Controller.clear();
//                                           capacitance2FocusNode.requestFocus();
//                                         } else {
//                                           capacitance2FocusNode.nextFocus();
//                                         }
//                                       } catch (e) {
//                                         EasyLoading.showError('Invalid input data');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: CustomInputField(
//                                     controller: txtInputCapacitance3Controller,
//                                     focusNode: capacitance3FocusNode,
//                                     readOnly: !capacitance3Checked,
//                                     keyboardType: TextInputType.number,
//                                     onChanged: (e) {
//                                       // context.read<ConnectionSettingBloc>().add(C)
//                                       validateSend();
//                                     },
//                                     onEditingComplete: () {
//                                       try {
//                                         if (!validateCapacitance(
//                                           txtCapacitanceMinController.text.isNotEmpty ? currentSerial.cuF0! : 0,
//                                           txtCapacitanceMaxController.text.isNotEmpty ? currentSerial.cuF10! : 999,
//                                           double.parse(txtInputCapacitance3Controller.text),
//                                         )) {
//                                           txtInputCapacitance3Controller.clear();
//                                           capacitance3FocusNode.requestFocus();
//                                         } else {
//                                           capacitance3FocusNode.nextFocus();
//                                         }
//                                       } catch (e) {
//                                         EasyLoading.showError('Invalid input data');
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(flex: 1, child: SizedBox()),
//                         Expanded(
//                             flex: 2,
//                             child: Row(
//                               children: [
//                                 // Expanded(
//                                 //   flex: 2,
//                                 //   child: CustomCheckBoxField(
//                                 //     value: hvTestChecked,
//                                 //     onChanged: (bool value) {
//                                 //       if (kDebugMode) {
//                                 //         print('CHECK: $value');
//                                 //       }
//                                 //       setState(() {
//                                 //         hvTestChecked = value;
//                                 //       });
//                                 //       if(value){
//                                 //         if(serials.isNotEmpty) {
//                                 //           txtHvTestController.text = serials.first.hvTest.toString();
//                                 //         }
//                                 //       }else{
//                                 //         txtHvTestController.clear();
//                                 //       }
//                                 //     },
//                                 //   ),
//                                 // ),

//                                 Expanded(
//                                   flex: 2,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       SizedBox(
//                                         width: 36,
//                                         child: CustomCheckBoxField(
//                                           value: hvTestChecked,
//                                           onChanged: (bool value) {
//                                             if (kDebugMode) {
//                                               print('CHECK: $value');
//                                             }
//                                             setState(() {
//                                               hvTestChecked = value;
//                                             });
//                                             checkBoxHvTest(value);
//                                             FocusScope.of(context).unfocus();
//                                           },
//                                         ),
//                                       ),
//                                       GestureDetector(
//                                           onTap: () {
//                                             setState(() {
//                                               hvTestChecked = !hvTestChecked;
//                                             });
//                                             checkBoxHvTest(hvTestChecked);
//                                             FocusScope.of(context).unfocus();
//                                           },
//                                           child: const AutoSizeText(
//                                             'HV. Test',
//                                           )),
//                                       const SizedBox(
//                                         width: 16,
//                                       )
//                                     ],
//                                   ),
//                                 ),

//                                 Expanded(
//                                   flex: 2,
//                                   child: CustomInputField(
//                                     controller: txtHvTestController,
//                                     readOnly: true,
//                                     onChanged: (e) {
//                                       // context.read<ConnectionSettingBloc>().add(C)
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Expanded(
//                               child: CustomButtonPrimary(
//                             color: sendValid ? colorDanger : colorInActive,
//                             text: offlineChecked ? 'Save' : 'Send',
//                             onPress: () {
//                               sendData(context);
//                             },
//                           )),
//                           const SizedBox(width: 6),
//                           Expanded(
//                               child: CustomButtonPrimary(
//                             color: colorPrimary,
//                             text: 'View',
//                             onPress: () {
//                               //context.read<ConnectionSettingBloc>().add(TestConnection(connectionUrlController.text));
//                               Get.toNamed('/summaryUnit', arguments: [
//                                 {"type": ViewType.online, "serialNo": txtSerialNoController.text}
//                               ]);
//                             },
//                           )),
//                           const SizedBox(width: 6),
//                           Expanded(
//                               child: CustomButtonPrimary(
//                             color: colorPrimaryLight,
//                             text: 'Cancel',
//                             onPress: () {
//                               //context.read<ConnectionSettingBloc>().add(Submit(connectionUrlController.text));
//                               // Get.back();
//                               resetControl();
//                               serialFocusNode.requestFocus();
//                             },
//                           )),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                           flex: 1,
//                           child: SizedBox(),
//                         ),
//                         Expanded(
//                             flex: 2,
//                             child: Row(
//                               children: [
//                                 // Expanded(
//                                 //   flex: 2,
//                                 //   child: Row(
//                                 //     mainAxisAlignment: MainAxisAlignment.start,
//                                 //     children: [
//                                 //       SizedBox(
//                                 //         width: 36,
//                                 //         child: CustomCheckBoxField(
//                                 //           value: offlineChecked,
//                                 //           onChanged: (bool value) {
//                                 //             if (kDebugMode) {
//                                 //               print('CHECK: $value');
//                                 //             }
//                                 //             setState(() {
//                                 //               offlineChecked = value;
//                                 //             });
//                                 //
//                                 //             checkBoxOffline(context, value);
//                                 //           },
//                                 //         ),
//                                 //       ),
//                                 //       GestureDetector(
//                                 //           onTap: () {
//                                 //             setState(() {
//                                 //               offlineChecked = !offlineChecked;
//                                 //             });
//                                 //             checkBoxOffline(context,offlineChecked);
//                                 //           },
//                                 //           child: const Text('Offline')),
//                                 //       const SizedBox(
//                                 //         width: 16,
//                                 //       )
//                                 //     ],
//                                 //   ),
//                                 // ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(right: 10.0, bottom: 0),
//                                     child: CustomButtonPrimary(
//                                       color: colorWarning,
//                                       text: 'View Offline',
//                                       padding: const EdgeInsets.symmetric(vertical: 14),
//                                       onPress: () {
//                                         Get.toNamed('/summaryUnit', arguments: [
//                                           {"type": ViewType.offline, "serialNo": txtSerialNoController.text}
//                                         ]);
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   void sendData(BuildContext context) {
//     if (sendValid) {
//       // if(!offlineChecked){
//       //
//       // }
//       // state.copyWith(serials: serials);
//       var serial = Serial();
//       if (serials.isNotEmpty) {
//         serial = serials[currentSerialIndex];
//       }

//       // serial.c
//       TestUnitData data = TestUnitData();
//       data.orderId = int.parse(serial.orderId ?? "0");
//       data.prdOrderNo = serial.prdOrderNo ?? "";
//       data.itemCode = serial.itemcode ?? "";
//       data.serial = int.parse(serial.serialUnit ?? "0");
//       data.rL1L2 = capacitance1Checked;
//       data.rL2L3 = capacitance2Checked;
//       data.rL3L1 = capacitance3Checked;
//       data.cL1L2 = txtInputCapacitance1Controller.text;
//       data.cL2L3 = txtInputCapacitance2Controller.text;
//       data.cL3L1 = txtInputCapacitance3Controller.text;
//       data.hvTest = hvTestChecked;

//       List<TestUnitData> listData = List<TestUnitData>.empty(growable: true);
//       listData.add(data);

//       //data store
//       if (offlineChecked) {
//         serial.orderId = null;
//         serial.prdOrderNo = null;
//         serial.itemcode = null;
//         serial.quantity = 1;
//         serial.description = null;
//         serial.serialUnit = txtSerialNoController.text.trim();
//         serial.rMin = null;
//         serial.rMax = null;
//         serial.cuF0 = null;
//         serial.cuF10 = null;
//         serial.isHvTest = hvTestChecked;
//         // serial.cL1L2: Value(serial.cL1L2);
//         // serial.cL2L3: Value(serial.cL2L3);
//         // serial.cL3L1: Value(serial.cL3L1);
//         // serial.isSend: Value(serial.isSend);
//         // serial.testPass: Value(serial.testPass);
//       }
//       serial.cL1L2 = txtInputCapacitance1Controller.text.isEmpty ? null : double.parse(txtInputCapacitance1Controller.text);
//       serial.cL2L3 = txtInputCapacitance2Controller.text.isEmpty ? null : double.parse(txtInputCapacitance2Controller.text);
//       serial.cL3L1 = txtInputCapacitance3Controller.text.isEmpty ? null : double.parse(txtInputCapacitance3Controller.text);
//       serial.isSend = false;
//       DateTime now = DateTime.now();
//       String formattedDate = DateFormat('HH:mm:ss').format(now);
//       serial.testPass = formattedDate;

//       context.read<TestUnitBloc>().add(FormSubmitted(sendSerial: listData, isOffline: offlineChecked, serial: serial));
//     }
//   }

//   Future<void> checkBoxOffline(BuildContext context, bool value) async {
//     if (value) {
//       await AlertConfirmDialog.confirm(
//           context: GlobalContextService.navigatorKey.currentContext!,
//           title: 'Confirm',
//           description: 'Do you confirm to clear old data from mobile?',
//           textConfirm: 'Yes',
//           textCancel: 'No',
//           onPressed: () {
//             // sendData(context);

//             //Clear data in local
//             context.read<TestUnitBloc>().add(const TestUnitRemove(serials: [], isClearAll: true));
//             Get.back();
//           },
//           onCancel: () {
//             Get.back();
//           });
//     }
//   }

//   void checkBoxHvTest(bool value) {
//     if (value) {
//       if (serials.isNotEmpty) {
//         txtHvTestController.text = serials.first.hvTest.toString();
//       }
//     } else {
//       txtHvTestController.clear();
//     }

//     validateSend();
//   }
// }
