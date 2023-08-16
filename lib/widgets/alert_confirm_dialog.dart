
import 'package:flutter/material.dart';

import '../config/config.dart';
import 'widget.dart';

class AlertConfirmDialog {
  static Future<void> confirm({
    required BuildContext context,
    bool? showConfirm = true,
    required String title,
    required String description,
    String? textConfirm,
    String? textCancel,
    required Function() onPressed,
    Function()? onCancel,
  }) async {
    // set up the buttons
    Widget cancelButton = CustomButtonPrimary(
      text: textCancel ?? "Cancel",
      hideLeadingIcon: true,
      color: colorSecondary,
      iconColor: Colors.white,
      textColor: Colors.white,
      height: 46,
      width: MediaQuery.of(context).size.width / 3,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      onPress: () => {if (onCancel == null) Navigator.of(context).pop() else onCancel()},
    );

    Widget continueButton = CustomButtonPrimary(
      text: textConfirm ?? "Confirm",
      hideLeadingIcon: true,
      color: colorSuccess,
      iconColor: Colors.white,
      textColor: Colors.white,
      height: 46,
      width: MediaQuery.of(context).size.width / 3,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      onPress: () => onPressed(),
    );

    // TextButton(
    //   child: Text(textConfirm ?? "Confirm"),
    //   onPressed: () => onPressed(),
    // );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text(title)),
      content: Text(description),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        cancelButton,
        showConfirm! ? continueButton : const SizedBox.shrink(),
      ],
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
    );

    // show the dialog
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> alert({
    required BuildContext context,
    required String title,
    String? description,
    Widget? widgetDescription,
    String? textConfirm,
    bool? hideConfirm = false,
    TextStyle? textStyle,
    required Function() onPressed,
  }) async {
    Widget continueButton = CustomButtonPrimary(
      text: textConfirm ?? "Confirm",
      hideLeadingIcon: true,
      color: colorPrimary,
      iconColor: Colors.white,
      textColor: Colors.white,
      height: 46,
      width: MediaQuery.of(context).size.width / 3,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      onPress: () => onPressed(),
    );

    AlertDialog alert = AlertDialog(
      title: Center(child: Text(title)),
      content: widgetDescription ?? Text(description ?? '', ),
      contentTextStyle: textStyle,
      actionsAlignment: MainAxisAlignment.center,
      actions: [hideConfirm == false ? continueButton : const SizedBox.shrink()],
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
    );

    // show the dialog
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
