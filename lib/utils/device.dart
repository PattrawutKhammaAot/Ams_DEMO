import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class Device {
  static Future<String> getId() async {
    // var deviceInfo = DeviceInfoPlugin();
    // if (Platform.isIOS) {
    //   var iosDeviceInfo = await deviceInfo.iosInfo;
    //   return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    // } else {
    //   var androidDeviceInfo = await deviceInfo.androidInfo;
    //   return androidDeviceInfo.androidId; // unique ID on Android
    // }

    String deviceIdentifier = "unknown";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      // if (androidInfo.id != null)
        deviceIdentifier = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      if (iosInfo.identifierForVendor != null) {
        deviceIdentifier = iosInfo.identifierForVendor!;
      }
    } else if (kIsWeb) {
      // The web doesnt have a device UID, so use a combination fingerprint as an example
      WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
      deviceIdentifier = webInfo.vendor! +
          webInfo.userAgent! +
          webInfo.hardwareConcurrency.toString();
    } else if (Platform.isLinux) {
      LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
      deviceIdentifier = linuxInfo.machineId!;
    }
    return deviceIdentifier;
  }

  static Future<dynamic> getDeviceDetail() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      if (kDebugMode) {
        print('Running on ${iosInfo.utsname.machine}');
      }
      return iosInfo;
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (kDebugMode) {
        print('Running on ${androidInfo.model}');
      } // e.g. "Moto G (4)"
      return androidInfo;
    }
  }
}
