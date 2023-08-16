import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import '../config/app_constants.dart';
import 'text_field_container.dart';

class CustomCheckBoxField extends StatelessWidget {
  final double size;

  // final Color fontColor;
  final Color color;

  // final Color iconColor;
  // final IconData icon;
  // final String? textValue;
  final ValueChanged<bool> onChanged;

  // final TextEditingController? controller;
  // final TextInputType? keyboardType;
  // final bool autocorrect;
  // final FormFieldValidator<String>? validator;
  // final InputDecoration? decoration;
  // final String? errorText;
  // final int? maxLine;
  final String? label;
  final bool? showLabelFloatLeft;
  final bool? value;

  const CustomCheckBoxField({
    Key? key,
    this.size = 35.0,
    // this.fontColor = Colors.black,
    this.color = Colors.blue,
    // this.icon = FontAwesomeIcons.envelope,
    // this.textValue,
    required this.onChanged,
    // this.controller,
    // this.keyboardType,
    // this.autocorrect = true,
    // this.validator,
    // this.iconColor = colorPrimary,
    // this.decoration,
    // this.errorText,
    // this.maxLine = 1,
    this.label,
    this.showLabelFloatLeft = false,
    this.value = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        // backColor: color,
        child: Center(
          child: MSHCheckbox(
            size: size,
            value: value!,
            //isChecked,
            colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
              checkedColor: color,
            ),
            style: MSHCheckboxStyle.fillScaleColor,
            onChanged: (selected) {
              // setState(() {
              //   isChecked = selected;
              //   //widget.value = selected;
              // });
              onChanged(selected);
            },
          ),
        ));
  }
}
