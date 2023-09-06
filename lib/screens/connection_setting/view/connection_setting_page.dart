import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../widgets/widget.dart';
import '../bloc/connection_setting_bloc.dart';

class ConnectionSettingPage extends StatefulWidget {
  const ConnectionSettingPage({Key? key}) : super(key: key);

  @override
  State<ConnectionSettingPage> createState() => _ConnectionSettingPageState();
}

class _ConnectionSettingPageState extends State<ConnectionSettingPage> {
  late TextEditingController connectionUrlController;
  String? connectionHint;

  @override
  void initState() {
    connectionUrlController = TextEditingController();
    initData();
    super.initState();
  }

  initData() async {
    var tmpConnection = await AppData.getApiUrl();
    setState(() {
      connectionHint = tmpConnection;
    });

    printInfo(info: "Test${tmpConnection}");
  }

  @override
  void dispose() {
    connectionUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Connection Setting'),
        ),
        body: BlocProvider(
          create: (context) =>
              ConnectionSettingBloc()..add(const LoadSetting()),
          child: BlocListener<ConnectionSettingBloc, ConnectionSettingState>(
            listener: (context, state) {
              if (state is ConnectionLoading) {
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              } else if (state is LoadedSetting) {
                EasyLoading.dismiss();
                connectionUrlController.text = state.connectionUrl;
              } else if (state is SaveSuccess) {
                //EasyLoading.dismiss();
                EasyLoading.showSuccess('Saved');
              } else if (state is TestConnectionSuccess) {
                //EasyLoading.dismiss();
                EasyLoading.showSuccess('Test Connect Successfully');
              } else if (state is ErrorMessage) {
                //EasyLoading.dismiss();
                EasyLoading.showError(state.message);
              } else {
                EasyLoading.dismiss();
              }
            },
            child: BlocBuilder<ConnectionSettingBloc, ConnectionSettingState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: CustomInputField(
                        controller: connectionUrlController,
                        labelText: 'Connection to server :',
                        helperText: 'URL such as ${connectionHint ?? "-"}',
                        maxLines: 5,
                        onChanged: (e) {
                          // context.read<ConnectionSettingBloc>().add(C)
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: CustomButtonPrimary(
                            text: 'Test Connection',
                            onPress: () {
                              context.read<ConnectionSettingBloc>().add(
                                  TestConnection(connectionUrlController.text));
                            },
                          )),
                          const SizedBox(width: 10),
                          Expanded(
                              child: CustomButtonPrimary(
                            text: 'Save',
                            onPress: () async {
                              context
                                  .read<ConnectionSettingBloc>()
                                  .add(Submit(connectionUrlController.text));
                            },
                          )),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
