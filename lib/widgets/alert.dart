import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../config/config.dart';
import '../data/models/api_response.dart';

class Alert {
  static void show({
    bool? showDefaultText = true,
    String? title,
    String? message,
    Color? color = colorSuccess,
    ReturnStatus? type,
    Duration? duration,
    bool? crossPage = false,
  }) {
    String showTitle = 'Alert';
    if (type == null) {
      showTitle = title ?? 'Alert';
    } else {
      if (title == null) {
        showTitle = type == ReturnStatus.SUCCESS
            ? 'Information'
            : type == ReturnStatus.ERROR
                ? 'Error'
                : 'Warning';
      } else {
        showTitle = title;
      }
    }

    late Icon leadingIcon;
    leadingIcon = type == ReturnStatus.SUCCESS
        ? const Icon(FontAwesomeIcons.circleInfo, color: colorSuccess)
        : type == ReturnStatus.ERROR
            ? const Icon(FontAwesomeIcons.circleXmark, color: colorDanger)
            : const Icon(FontAwesomeIcons.circleExclamation,
                color: colorWarning);

    // BotToast.showSimpleNotification(
    //   title: showTitle, //showDefaultText! ? 'Success' : message!,
    //   titleStyle: const TextStyle(
    //       // color: Colors.white,
    //       fontWeight: FontWeight.bold),
    //   subTitle: message,
    //   // subTitleStyle: const TextStyle(
    //   //   color: Colors.white,
    //   // ),
    //   // closeIcon: const Icon(
    //   //   Icons.close,
    //   //   color: Colors.white38,
    //   // ),
    //   backgroundColor: type == null
    //       ? color
    //       : type == ReturnStatus.SUCCESS
    //           ? colorSuccess
    //           : type == ReturnStatus.ERROR
    //               ? colorDanger
    //               : colorWarning,
    //   //hideCloseButton: true,
    //   crossPage: false,
    //   borderRadius: 18,
    //   duration: duration ?? const Duration(seconds: 5),
    // );

    BotToast.showNotification(
      leading: (cancel) => SizedBox.fromSize(
          size: const Size(40, 40),
          child: IconButton(
            iconSize: 30,
            icon: leadingIcon,
            onPressed: cancel,
          )),
      title: (_) => Text(showTitle, style: const TextStyle(fontWeight: FontWeight.bold),),
      subtitle: (_) => Text(message ?? ''),
      trailing: (cancel) => IconButton(
        icon: const Icon(Icons.close),
        onPressed: cancel,
      ),
      backgroundColor: type == null
          ? color
          : type == ReturnStatus.SUCCESS
              ? colorSuccess
              : type == ReturnStatus.ERROR
                  ? colorDanger
                  : colorWarning,
      // onTap: () {
      //   BotToast.showText(text: 'Tap toast');
      // },
      // onLongPress: () {
      //   BotToast.showText(text: 'Long press toast');
      // },
      // enableSlideOff: enableSlideOff,
      // backButtonBehavior: backButtonBehavior,
      crossPage: crossPage!,
      contentPadding: const EdgeInsets.all(6),
      // onlyOne: onlyOne,
      // animationDuration:
      //     Duration(milliseconds: animationMilliseconds),
      // animationReverseDuration:
      //     Duration(milliseconds: animationReverseMilliseconds),
      duration: duration ?? const Duration(seconds: 5),
    );
  }

  static Future<void> clear() async {
    BotToast.cleanAll();
  }
}
