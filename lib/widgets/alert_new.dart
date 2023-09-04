import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertWarningNew {
  void alertShow(BuildContext context,
      {AlertType? type ,
      String? title,
      String? desc,
      bool isHide = true,
      Function()? onPress,
      Function()? onBack}) {
    Alert(
      context: context,
      type: type ?? AlertType.warning,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            "BACK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: onBack,
          width: 120,
        ),
        DialogButton(
          color: colorActive,
          child: Text(
            "NEXT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: onPress,
          width: 120,
        ),
      ],
    ).show();
  }

  void alertShowOK(
    BuildContext context, {
    AlertType? type,
    String? title,
    String? desc,
    bool isHide = true,
    Function()? onPress,
  }) {
    Alert(
      context: context,
      type: type,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          color: colorActive,
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: onPress,
          width: 120,
        ),
      ],
    ).show();
  }
}
