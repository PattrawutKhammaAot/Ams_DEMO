// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  AppData._();

  // late SharedPreferences storage;
  //
  // AppData() {
  //   initializeSharedPreferences();
  // }
  //
  // Future<void> initializeSharedPreferences() async {
  //   storage = await SharedPreferences.getInstance();
  //   // Perform any other initialization tasks with SharedPreferences
  // }

  ///Setting
  static setApiUrl(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await storage.write(key: "ApiUrl", value: value);
    await prefs.setString("ApiUrl", value);

    print(value);
  }

  static dynamic getApiUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? value = await storage.read(key: "ApiUrl");
    // return value;
    return prefs.getString("ApiUrl");
  }

  static Future<PackageInfo> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // print(packageInfo);
    return packageInfo;
  }

  static setDarkMode(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("darkMode", value);
  }

  static dynamic getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? value =  prefs.getString( "darkMode");
    return prefs.getString("darkMode");
  }

  static Future<bool> isDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("darkMode");
    bool result = value == null
        ? false
        : value == "true"
            ? true
            : false;
    return result;
  }

  static setSystemTheme(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("systemTheme", value);
  }

  static Future<bool> isSystemTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("systemTheme");
    bool result = value == null
        ? false
        : value == "true"
            ? true
            : false;
    return result;
  }

  //
  static setMainMenuGridMode(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("MainMenuGridMode", value);
  }

  static dynamic getMainMenuGridMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("MainMenuGridMode");
    return value;
  }

  static Future<bool> isMainMenuGrid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("MainMenuGridMode");
    bool result = value == null
        ? false
        : value == "true"
            ? true
            : false;
    return result;
  }

  ///

  static setLanguageCode(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("languageCode", value);
  }

  static dynamic getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("languageCode");
    return value;
  }

  static setCountryCode(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("countryCode", value);
  }

  static dynamic getCountryCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("countryCode");
    return value;
  }

  static setLanguageTitle(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("languageTitle", value);
  }

  static dynamic getLanguageTitle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("languageTitle");
    return value;
  }

  static setLocal(String languageCode, String countryCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("languageCode", languageCode);
    await prefs.setString("countryCode", countryCode);
  }

  static dynamic getLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langValue = prefs.getString("languageCode");
    String? countryValue = prefs.getString("countryCode");
    var value = "${langValue ?? "en"}-${countryValue ?? "US"}";
    return value;
  }

  static setLocalId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("LocalId", value);
  }

  static dynamic getLocalId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("LocalId");
    return value;
  }

  static dynamic getAppLanguage() async {
    String? title = await getLanguageTitle();
    String? countryCode = await getCountryCode();
    String? languageCode = await getLanguageCode();
    var value = AppLanguage(
        title: title, languageCode: languageCode, countryCode: countryCode);
    return value;
  }

  ///Authen
  static setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", value);
  }

  static dynamic getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("accessToken");
    return value ?? '';
  }

  static setUser(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", value);
  }

  static dynamic getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("userId");
    return value;
  }

  static setUserFullName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("UserFullName", value);
  }

  static dynamic getUserFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("UserFullName");
    return value;
  }

  static setUserName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("UserName", value);
  }

  static dynamic getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("UserName");
    return value;
  }

  static setEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userEmail", value);
  }

  static dynamic getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("userEmail");
    return value;
  }

//For Status Mode On Off Line
  static setMode(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Mode", value);
  }

  static dynamic getMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("Mode");
    return value;
  }

  static setPlanReport(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Plan", value);
  }

  static dynamic getPlan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("Plan");
    return value;
  }

  ///Dispose
  static dispose() async {
    // await storage.delete(key: "darkMode");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

class AppLanguage {
  final String? title;
  final String? languageCode;
  final String? countryCode;

  AppLanguage({this.title, this.languageCode, this.countryCode});
}
