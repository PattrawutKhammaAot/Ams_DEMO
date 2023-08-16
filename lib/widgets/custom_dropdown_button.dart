import 'package:flutter/material.dart';

import '../config/app_constants.dart';


class DropDownProperty {
  String value;
  String displayValue;
  Object? valueObject;

  DropDownProperty(this.value, this.displayValue, this.valueObject);
}

class CustomDropdownButton extends StatefulWidget {
  final bool? disable;
  final bool paddingTop;
  final bool paddingBottom;
  String? selectedValue;
  String? defaultValue;
  final List<DropdownMenuItem<String>> items;
  final Function(String?)? onChanged;
  final String? hint;
  final String? label;

  CustomDropdownButton({
    Key? key,
    this.disable = false,
    this.paddingTop = true,
    this.paddingBottom = false,
    this.selectedValue = '',
    this.defaultValue = '',
    required this.items,
    this.onChanged, this.hint, this.label,
  }) : super(key: key);

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {

  @override
  Widget build(BuildContext context) {
    var isLabelEmpty =  widget.label == null ? true : false;

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 8),
      // decoration: BoxDecoration(
      //     border: Border.all(color: Colors.grey.shade100, width: 8.0)
      // ),
      child: Padding(
        padding: EdgeInsets.only(
          top: (widget.paddingTop ? 8 : 0.0),
          bottom: (widget.paddingBottom ? 16.0 : 0.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: (isLabelEmpty ? 0 : 5.0) ),
              child: Text(widget.label ?? '', style: const TextStyle(color: colorTitleSecondDark),),
            ),
            Material(
              elevation: 4.0,
              shadowColor: Colors.black54,
              borderRadius: BorderRadius.circular(10),
              //shape:  ,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButton<String>(
                  value: widget.defaultValue,
                  //icon: const Icon(Icons.arrow_downward),
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),
                  hint: Text('${widget.hint}'),
                  isExpanded: true,
                  style: const TextStyle(color: colorTitleDark, fontSize: 16),
                  // underline: Container(
                  //   height: 2,
                  //   color: Colors.deepPurpleAccent,
                  // ),
                  underline: Container(),
                  onChanged: widget.disable!
                      ? null
                      : (String? newValue) {
                          setState(() {
                            widget.defaultValue = newValue!;
                          });
                          widget.selectedValue = newValue;

                          widget.onChanged!(newValue);
                        },
                  items: widget.items,
                  // <String>['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem<String>>((String value) {
                  //   return DropdownMenuItem<String>(
                  //     value: value,
                  //     child: Text(value),
                  //   );
                  // }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
