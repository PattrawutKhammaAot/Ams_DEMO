
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../config/app_constants.dart';
import 'text_field_container.dart';

class CustomPasswordField extends StatefulWidget {
  final double fontSize;
  final Color fontColor;
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String? errorText;

  const CustomPasswordField({Key? key, this.fontSize = 18.0, this.fontColor = Colors.black, this.hintText = "Password", required this.onChanged, this.controller, this.validator, this.errorText}) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isObscure,
        validator: widget.validator,
        onChanged: widget.onChanged,
        cursorColor: colorPrimary,
        style: TextStyle(fontSize: widget.fontSize, color: widget.fontColor),
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: const Icon(
            FontAwesomeIcons.lock,
            color: colorPrimary,
          ),
          suffixIcon: IconButton(
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              }),
          border: InputBorder.none,
          filled: false,
          errorText: widget.errorText
        ),
      
      ),
    );
  }
}
