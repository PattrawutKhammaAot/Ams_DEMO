import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../../../config/config.dart';
import '../../../utils/util.dart';

class ApiService {
  // String? externalUrl;

  ApiService() {
    // init();
  }

  late String deviceUuid = "";
  late String token = "";
  final dio = Dio(); // With default `Options`.

  Future<void> configureDio() async {
    // Set default configs
    dio
      ..options.baseUrl = await getHost()
      ..options.connectTimeout = const Duration(seconds: 50)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.responseType = ResponseType.json
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));

    /// Fix for some customer has block proxy
    // const String fingerprint = 'ee5ce1dfa7a53657c545c62b65802e4272878dabd65c0aadcf85783ebb0b4d5c';
    dio.httpClientAdapter = IOHttpClientAdapter(
      onHttpClientCreate: (_){
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
      // validateCertificate: (cert, host, port) {
      //   // Check that the cert fingerprint matches the one we expect.
      //   // We definitely require _some_ certificate.
      //   if (cert == null) {
      //     return false;
      //   }
      //   // Validate it any way you want. Here we only check that
      //   // the fingerprint matches the OpenSSL SHA256.
      //   return fingerprint == sha256.convert(cert.der).toString();
      // },
    );
  }

  Future<void> init() async {
    deviceUuid = await Device.getId();
    await configureDio();
    token = await AppData.getToken();
  }

  Future<String> getHost() async {
    var configHost = await AppData.getApiUrl();
    var url = configHost ?? apiUrl;
    if (kDebugMode) {
      print('Connect Host: $url');
    }

    //   String modifiedUrl = url.replaceAllMapped(
    //     RegExp(r'^(.*?)(\/api\/)?(?:\/)?(?:\?|$)'), (Match match) {
    //   if (match.group(2) == null) {
    //     return '${match.group(1)}/api/';
    //   } else {
    //     return url;
    //   }
    // });

    //   if (kDebugMode) {
    //     print(modifiedUrl); // Output: http://example.com/path/api/
    //   }

    return url.toString().endsWith('/') ? '${url.toString()}/' : '$url/';
  }

  Future<Response> get(String function, String param,
      {ProgressCallback? onReceiveProgress, bool useAuth = true}) async {
    // final prefs = await SharedPreferences.getInstance();
    // final String token = prefs.getString('token') ?? "";
    try {
      var option = Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.acceptHeader: "*/*",
        "Application-Key": appKey,
        "Action-By": await AppData.getUserName(),
        "Locale-Id": await AppData.getLocalId(),
        "Device-Id": deviceUuid,
      });

      if (!useAuth) {
        option = Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          HttpHeaders.acceptHeader: "*/*",
          "Application-Key": appKey,
          "Action-By": await AppData.getUserName(),
          "Locale-Id": await AppData.getLocalId(),
          "Device-Id": deviceUuid,
        });
      }

      Response response = await dio.get(
        '$function?$param',
        options: option,
        onReceiveProgress: onReceiveProgress,
      );
      if (kDebugMode) {
        print(response.data);
        print(response.statusCode);
      }
      // if (response.statusCode == 401) {
      //   // call your refresh token api here and save it in shared preference
      //   await getToken();
      //   signInData(data);
      // }

      //   if (response) {
      //   return Future.error(response.statusText!);
      // } else {
      //   return response.data;
      // }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // return Future.error(e.toString());
      rethrow;
    }
  }


  Future<Response> post(String function, Map data,
      {ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool useAuth = true}) async {
    // try {
    //   var device = await Device.getId();
    //   final response = await post(apiFunction, data, headers: {
    //     "Accept": "*/*",
    //     "Authorization": "Bearer " + await AppController.getToken(),
    //     "Content-Type": "application/json; charset=UTF-8",
    //     "Application-Key": appKey,
    //     "Action-By": await AppController.getUserName(),
    //     "Plant-Code": await AppController.getPlantCode(),
    //     "Locale-Id": await AppData.getLocalId(),
    //     "Device-Id": device,
    //   });
    //   if (response.status.hasError) {
    //     return Future.error(response.statusText!);
    //   } else {
    //     return response.body;
    //   }
    // } catch (exception) {
    //   return Future.error(exception.toString());
    // }

    try {
      var option = Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.acceptHeader: "*/*",
        "Application-Key": appKey,
        "Action-By": await AppData.getUserName(),
        "Locale-Id": await AppData.getLocalId(),
        "Device-Id": deviceUuid,
      });

      if (!useAuth) {
        option = Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          HttpHeaders.acceptHeader: "*/*",
          "Application-Key": appKey,
          "Action-By": await AppData.getUserName(),
          "Locale-Id": await AppData.getLocalId(),
          "Device-Id": deviceUuid,
        });
      }

      Response response = await dio.post(
        function,
        data: data,
        options: option,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (kDebugMode) {
        print(response.data);
        print(response.statusCode);
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // return Future.error(e.toString());
      rethrow;
    }
  }

  Future<dynamic> postJson(String function, String data,
      {ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool useAuth = true}) async {
    // try {
    //   var device = await Device.getId();
    //   var body = utf8.encode(data);
    //   final response = await post(apiFunction, data,
    //       // contentType: "application/json;",
    //       headers: {
    //         "Accept": "*/*",
    //         "Authorization": "Bearer " + await AppController.getToken(),
    //         "Content-Type": "application/json; charset=UTF-8",
    //         //"Connection": "keep-alive",
    //         //"Accept-Encoding": "gzip, deflate, br",
    //         // "Content-Length": body.length.toString(),
    //         "Application-Key": appKey,
    //         "Action-By": await AppController.getUserName(),
    //         "Plant-Code": await AppController.getPlantCode(),
    //         "Locale-Id": await AppData.getLocalId(),
    //         "Device-Id": device,
    //       }).timeout(Duration(minutes: 5));
    //   if (response.status.hasError) {
    //     return Future.error(response.statusText!);
    //   } else {
    //     return response.body;
    //   }
    // } catch (exception) {
    //   return Future.error(exception.toString());
    // }

    try {
      var option = Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.acceptHeader: "*/*",
        "Application-Key": appKey,
        "Action-By": await AppData.getUserName(),
        "Locale-Id": await AppData.getLocalId(),
        "Device-Id": deviceUuid,
      });

      if (!useAuth) {
        option = Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          HttpHeaders.acceptHeader: "*/*",
          "Application-Key": appKey,
          "Action-By": await AppData.getUserName(),
          "Locale-Id": await AppData.getLocalId(),
          "Device-Id": deviceUuid,
        });
      }

      // var body = utf8.encode(data);
      Response response = await dio.post(
        function,
        data: data,
        options: option,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (kDebugMode) {
        print(response.data);
        print(response.statusCode);
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // return Future.error(e.toString());
      rethrow;
    }
  }

  Future<dynamic> delete(String function, String data,
      {CancelToken? cancelToken, bool useAuth = true}) async {
    try {
      var option = Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.acceptHeader: "*/*",
        "Application-Key": appKey,
        "Action-By": await AppData.getUserName(),
        "Locale-Id": await AppData.getLocalId(),
        "Device-Id": deviceUuid,
      });

      if (!useAuth) {
        option = Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
          HttpHeaders.acceptHeader: "*/*",
          "Application-Key": appKey,
          "Action-By": await AppData.getUserName(),
          "Locale-Id": await AppData.getLocalId(),
          "Device-Id": deviceUuid,
        });
      }

      var body = utf8.encode(data);
      Response response = await dio.delete(
        function,
        data: body,
        options: option,
        cancelToken: cancelToken,
      );
      if (kDebugMode) {
        print(response.data);
        print(response.statusCode);
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // return Future.error(e.toString());
      rethrow;
    }
  }
}
