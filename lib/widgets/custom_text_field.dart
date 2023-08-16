// import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'text_field_container.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../config/app_constants.dart';
// import 'package:wms/features/constants/app_constants.dart';

enum InputType { text, email, number, password, phone }

class CustomInputField extends StatefulWidget {
  final bool obscureText;
  final String? hintText;
  final double fontSize;
  final double height;
  final Color fontColor;
  final Color backColor;
  final IconData icon;
  final String? textValue;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
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
  final InputType inputType;
  final bool isScan;
  final ValueChanged<String>? barcodeListen;
  final bool visible;
  final bool showCounterText;
  final FocusNode? focusNode;
  final Function()? onTap;
  final TextAlign? textAlign;
  final bool selectAllOnTap;
  final TextInputAction textInputAction;
  final String? resourceGroup;
  final String? resourceName;
  final TextCapitalization? textCapitalization;
  final String? errorText;
  final String? helperText;
  final bool? showLabelFloatLeft;
  final Function(PointerDownEvent)? onTapOutside;
  final Function()? onEditingComplete;

  const CustomInputField({
    Key? key,
    this.obscureText = false,
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
    this.readOnly = false,
    this.paddingTop = true,
    this.paddingBottom = false,
    this.require = true,
    this.inputType = InputType.text,
    this.isScan = false,
    this.barcodeListen,
    this.visible = true,
    this.showCounterText = false,
    this.focusNode,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.selectAllOnTap = false,
    this.textInputAction = TextInputAction.search,
    this.resourceGroup,
    this.resourceName,
    this.textCapitalization = TextCapitalization.none,
    this.errorText,
    this.helperText,
    this.showLabelFloatLeft = false, this.onFieldSubmitted, this.onTapOutside, this.onEditingComplete,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomInputField> {
  RegExp digitValidator = RegExp("[0-9]+");
  var isValid = true;
  var errMessage = '';

  // late StreamSubscription streamToken;
  // Map<String, int> detectionCount = {};

  @override
  void initState() {
    super.initState();
    // streamToken = codeStream.stream.listen((event) {
    //   // final count = detectionCount.update(event.value, (value) => value + 1,
    //   //     ifAbsent: () => 1);
    //   // detectionInfo.value = "${count}x\n${event.value}";
    // });
  }

  @override
  Widget build(BuildContext context) {
    // return Visibility(
    //   visible: widget.visible,
    //   child: Padding(
    //     padding: EdgeInsets.only(
    //       top: (widget.paddingTop ? 16.0 : 0.0),
    //       bottom: (widget.paddingBottom ? 16.0 : 0.0),
    //     ),
    //     child: Material(
    //       elevation: 4.0,
    //       shadowColor: Colors.black54,
    //       borderRadius: BorderRadius.circular(10),
    //       child: buildTextFormField(),
    //     ),
    //   ),
    // );

    return Visibility(
      visible: widget.visible,
      child: TextFieldContainer(
        backColor: widget.backColor,
        height: widget.maxLines! > 1 ? 20 * double.parse( widget.maxLines!.toString()) : 42,
        child: widget.showLabelFloatLeft!
            ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.3,
                  child: Align(
                      alignment: widget.maxLines! > 1 ? Alignment.topRight : Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.0, top: widget.maxLines! > 1 ? 1 : 0),
                        child: Text(widget.labelText ?? ""),
                      )),
                ),
                Expanded(child: buildTextFormField()),
              ])
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.labelText != null ? Text(widget.labelText ?? "") : const SizedBox(),
                  Expanded(child: buildTextFormField()),
                ],
              ),
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      // initialValue: widget.textValue,
      textCapitalization: widget.textCapitalization!,
      textAlign: widget.textAlign!,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      // inputFormatters: widget.inputType == InputType.number ? [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))] : null,
      inputFormatters: widget.inputType == InputType.number ? [FilteringTextInputFormatter.allow((RegExp("[0-9]")))] : null,
      textInputAction: widget.isScan ? widget.textInputAction : null,
      // onFieldSubmitted: (val) {
      //   if (widget.barcodeListen != null) widget.barcodeListen!(val == "" ? "" : val);
      // },
      onFieldSubmitted: widget.onFieldSubmitted,
      onEditingComplete: widget.onEditingComplete,
      onTapOutside: widget.onTapOutside,

      decoration: InputDecoration(
        //filled: true,
        //fillColor: widget.readOnly ? Colors.grey.shade300 : Colors.white,
        // contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),

        // contentPadding: EdgeInsets.all(-4),
         contentPadding: widget.maxLines! > 1 ? const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10) : const EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
        counterText: widget.showCounterText ? null : '',
        // labelText: '${widget.labelText}${widget.require && !widget.readOnly ? '*' : ''}',
        // hintText: '${widget.hintText}${widget.require ? '' : ''}',
        // '${widget.hintText}${widget.require ? '' : ' (optional)'}',

        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white, width: 3.0)),
        // enabledBorder:
        //     OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.grey.shade100, width: 1.0)),

        // errorText: isValid ? null : "\u2297 This field is required\r\n",
        // errorStyle: const TextStyle(color: colorDanger),
        //focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorDanger)),
        //errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorDanger))
        // suffixIcon: widget.isScan
        //     ? IconButton(
        //         //onPressed: _controller.clear,
        //         icon: Icon(Icons.qr_code_scanner),
        //         onPressed: () async {
        //           String barcodeScanRes = '';
        //           // Platform messages may fail, so we use a try/catch PlatformException.
        //           try {
        //             // barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //             //     // '#ff6666', 'App General|Cancel'.tr, true, ScanMode.DEFAULT);
        //             //     '#ff6666', 'App General|Cancel'.tr, true, ScanMode.BARCODE);
        //             // print(barcodeScanRes);
        //
        //             /// Fast Barcode Scanner
        //             //Navigator.push(context, MaterialPageRoute(builder: (context) => ScannerScreen()));
        //             var data = await Get.to(ScannerScreen());
        //             widget.barcodeListen!(data.value ?? '');
        //             // await Get.to(ScannerScreen())!.then((value) {
        //             //   streamToken = codeStream.stream.listen((event) {
        //             //     // final count = detectionCount.update(event.value, (value) => value + 1, ifAbsent: () => 1);
        //             //     //detectionInfo.value = "${count}x\n${event.value}";
        //             //     barcodeScanRes = event.value;
        //             //
        //             //     widget.barcodeListen!(event.value ?? '');
        //             //   });
        //             // });
        //
        //           } on PlatformException {
        //             barcodeScanRes = 'Failed to get platform version.';
        //           }
        //
        //           // If the widget was removed from the tree while the asynchronous platform
        //           // message was in flight, we want to discard the reply rather than calling
        //           // setState to update our non-existent appearance.
        //           if (!mounted) return;
        //
        //           // widget.barcodeListen!(barcodeScanRes == "-1" ? "" : barcodeScanRes);
        //         },
        //       )
        //     : null,

        hintText: widget.hintText,
        helperText: widget.helperText,
        helperMaxLines: 2,
        // border: InputBorder.none,
        filled: widget.readOnly ? true : false,
        fillColor: Colors.grey.shade300,
        errorText: widget.errorText,
        errorStyle: const TextStyle(color: colorDanger),


        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          // gapPadding: 0,
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          // gapPadding: 0,
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            // width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          // gapPadding: 0,
          borderSide: BorderSide(),
        ),
      ),
      validator: (value) {
        if (!isValid) {
          return '\u26A0 ' "This field is required";
        } else {
          if (widget.require && value!.isEmpty) {
            return "\u2297 This field is required\r\n";
          }
        }
        return null;
      },
      onSaved: (val) {
        if (kDebugMode) {
          print('saved');
        }
      },
      onChanged: (inputValue) {
        if (widget.require && inputValue.isEmpty) {
          setValidator(false);
        } else {
          if (widget.keyboardType == TextInputType.number && widget.require) {
            digitValidator.hasMatch(inputValue) ? setValidator(true) : setValidator(false);
          } else {
            setValidator(true);
          }
        }
        if(widget.onChanged!= null) {
          widget.onChanged!(inputValue);
        }
      },
      onTap: () => widget.selectAllOnTap ? widget.controller!.selection = TextSelection(baseOffset: 0, extentOffset: widget.controller!.text.length) : widget.onTap,
      controller: widget.controller,
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

  @override
  void dispose() {
    // streamToken.cancel();
    super.dispose();
  }
}

///Barcode Reader
// final codeStream = StreamController<Barcode>.broadcast();
//
// class ScannerScreen extends StatefulWidget {
//   const ScannerScreen({Key? key}) : super(key: key);
//
//   @override
//   _ScannerScreenState createState() => _ScannerScreenState();
// }
//
// class _ScannerScreenState extends State<ScannerScreen> {
//   final _torchIconState = ValueNotifier(false);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const Text(
//           '',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           ValueListenableBuilder<bool>(
//             valueListenable: _torchIconState,
//             builder: (context, state, _) => IconButton(
//               icon: state ? const Icon(Icons.flash_on) : const Icon(Icons.flash_off),
//               onPressed: () async {
//                 await CameraController.instance.toggleTorch();
//                 _torchIconState.value = CameraController.instance.state.torchState;
//               },
//             ),
//           ),
//         ],
//       ),
//       body: BarcodeCamera(
//         types: const [
//           BarcodeType.ean8,
//           BarcodeType.ean13,
//           BarcodeType.code128,
//           BarcodeType.code39,
//           BarcodeType.code93,
//           //BarcodeType.qr
//         ],
//         resolution: Resolution.hd720,
//         framerate: Framerate.fps30,
//         mode: DetectionMode.pauseVideo,
//         position: CameraPosition.back,
//         // onScan: (code) => codeStream.add(code),
//         onScan: (code) => {
//           codeStream.add(code), Get.back(result: code)
//         },
//         children: [
//           const MaterialPreviewOverlay(animateDetection: false),
//           const BlurPreviewOverlay(),
//           // Positioned(
//           //   bottom: 50,
//           //   left: 0,
//           //   right: 0,
//           //   child: Column(
//           //     children: [
//           //       ElevatedButton(
//           //         child: const Text("Resume"),
//           //         onPressed: () => CameraController.instance.resumeDetector(),
//           //       ),
//           //       const SizedBox(height: 20),
//           //       const DetectionsCounter()
//           //     ],
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
// }
