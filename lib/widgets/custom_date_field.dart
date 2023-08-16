import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/app_data.dart';
import '../config/app_constants.dart';

class CustomDateField extends StatefulWidget {
  final String? hintText;
  final double fontSize;
  final double height;
  final Color fontColor;
  final Color backColor;
  final IconData icon;
  final String? textValue;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool autocorrect;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final bool paddingTop;
  final bool paddingBottom;
  final bool require;
  final bool isScan;
  final ValueChanged<String>? barcodeListen;
  final bool visible;
  final bool defaultToday;

  const CustomDateField({
    Key? key,
    this.hintText = '',
    this.fontSize = 18.0,
    this.height = 1.0,
    this.fontColor = Colors.black,
    this.backColor = colorLight,
    this.icon = Icons.person,
    this.textValue,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.autocorrect = true,
    this.validator,
    this.labelText,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = true,
    this.paddingTop = true,
    this.paddingBottom = false,
    this.require = true,
    this.isScan = false,
    this.barcodeListen,
    this.visible = true,
    this.defaultToday = false,
  }) : super(key: key);

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  var isValid = true;
  var errMessage = '';
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    var localId = await AppData.getLocalId();
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021, 1), lastDate: DateTime(2101), locale: localId == '1033' ? Locale('en', '') : Locale('th', 'TH'));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    //});
    widget.controller!
      ..text = DateFormat('dd/MM/yyyy').format(selectedDate)
      ..selection = TextSelection.fromPosition(TextPosition(offset: widget.controller!.text.length, affinity: TextAffinity.upstream));

    if (widget.onChanged != null) {
      widget.onChanged!(selectedDate.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // var dateNow = DateTime.now();
    // if (widget.defaultToday) {
    //   widget.controller!.text = DateFormat('dd/MM/yyyy').format(dateNow);
    // }

    return Visibility(
      visible: widget.visible,
      child: Padding(
        padding: EdgeInsets.only(
          top: (widget.paddingTop ? 16.0 : 0.0),
          bottom: (widget.paddingBottom ? 16.0 : 0.0),
        ),
        child: Material(
          elevation: 4.0,
          shadowColor: Colors.black54,
          borderRadius: BorderRadius.circular(10),
          child: TextFormField(
            //initialValue: "${selectedDate.toLocal()}".split(' ')[0],
            showCursor: true,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            //inputFormatters: widget.inputType == InputType.number ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] : null,
            decoration: InputDecoration(
              labelText: '${widget.labelText}${widget.require ? '*' : ''}',
              hintText: '${widget.hintText}${widget.require ? '' : ' '}',

              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white, width: 3.0)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade100, width: 1.0)),

              errorText: isValid ? null : "\u2297 " "This field is required",
              errorStyle: const TextStyle(color: colorDanger),
              //focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorDanger)),
              //errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorDanger))
            ),
            validator: (value) {
              if (!isValid) {
                return '\u26A0 ' "This field is required";
              }
              return null;
            },
            onChanged: (inputValue) {
              if (widget.require && inputValue.isEmpty) {
                setValidator(false);
              } else {
                setValidator(true);

                // if(  widget.onChanged != null )
                //   widget.onChanged!(inputValue);
              }
            },
            onTap: () {
              selectDate(context);
            },
            controller: widget.controller,
          ),
        ),
      ),
    );
  }

  void setValidator(bool valid, {String? err = ''}) {
    setState(() {
      isValid = valid;
      errMessage = err!;
    });
    if (kDebugMode) {
      print(valid);
    }
  }
}
