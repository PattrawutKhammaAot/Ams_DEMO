import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../app.dart';
//import '../../../blocs/home/home.dart';
import '../../../config/app_constants.dart';
import '../../../config/app_data.dart';
import '../../../widgets/widget.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }
}

class _LoginPageState extends State<LoginPage> {
  late PackageInfo packageInfo;
  late String appVersion;
  late bool offlineChecked;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    appVersion = "";
    getAppInfo();

    _usernameController.text = "";
    _passwordController.text = "";
   // offlineChecked = false;

    super.initState();
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
      backgroundColor: colorBackgroundGray,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == FetchStatus.failed) {
            //_debug();
          }else if (state.status == FetchStatus.success) {
            //Get.toNamed('/');
            //Navigator.pushNamed(context, AppRoute.home);
          }
        },
        child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildBanner(),
                  _buildForm(),
                ],
              ),
            ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton.extended(
              onPressed: () {
                Get.toNamed('/connectionSetting');
              },
              backgroundColor: colorPrimaryDark,
              icon: const Icon(Icons.settings),
              label: const Text('Setting Web'),
            ),
            SizedBox(
              height: 30,
              child: Column(
                children: [
                  Text('Version $appVersion', style: const TextStyle(fontSize: 12),),
                  const Text('Modified On: 8 Jun 2023', style: TextStyle(fontSize: 8),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildBanner() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Image.asset(logoImage),
    );
  }

  _buildForm() {
    return Card(
      elevation: 7,
      margin: const EdgeInsets.only(top: 50, left: 32, right: 32),
      // height: 300,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text("LOGIN",
                     style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: colorPrimaryLight),
                 ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Username",
                  icon: Icon(Icons.person),
                  //hintText: "",
                   ),
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Password",
                  icon: Icon(Icons.password_outlined),
                  //hintText: "Password",
                  ),
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: _handleLogin, child: const Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(64, 60) // put the width and height you want, standard ones are 64, 40
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _handleLogin() {
    context.read<AuthBloc>().add(AuthEvent_Login(_usernameController.text, _passwordController.text,));
  }

  void _debug() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: SizedBox(
              height: 300,
              child: Column(
                children: [
                  const Text("Debug"),
                  Text("Username : ${_usernameController.text}"),
                  Text("Username : ${_passwordController.text}"),
                ],
              ),
            ));
      },
    );
  }

}
