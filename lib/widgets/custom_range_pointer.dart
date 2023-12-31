import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CustomRangePoint extends StatelessWidget {
  const CustomRangePoint(
      {super.key,
      required this.valueRangePointer,
      required this.allItem,
      this.color,
      this.text,
      this.colorText});
  final int? valueRangePointer;
  final int? allItem;

  final Color? color;
  final String? text;

  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
              minimum: 0,
              maximum: double.parse(
                  allItem.toString() == "0" || allItem.toString().isEmpty
                      ? "1".toString()
                      : allItem.toString()),
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 1,
              axisLineStyle: const AxisLineStyle(
                  thicknessUnit: GaugeSizeUnit.factor, thickness: 0.16),
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  angle: 60,
                  widget: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${valueRangePointer?.toInt() ?? "-"}',
                                  style: TextStyle(
                                    fontFamily: 'Times',
                                    fontSize: 16,
                                    color: colorText,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                // TextSpan(
                                //     text: '${allItem?.toInt() ?? "-"}',
                                //     style: TextStyle(
                                //       fontSize: 16,
                                //       color: colorText,
                                //       fontWeight: FontWeight.w400,
                                //       overflow: TextOverflow.ellipsis,
                                //     )),
                              ],
                            ),
                          ),
                        ),
                        text != null || text == ""
                            ? FittedBox(
                                fit: BoxFit.cover,
                                child: Label(
                                  "${text}",
                                  color: colorPrimary,
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                ),
              ],
              pointers: <GaugePointer>[
                RangePointer(
                    value: double.tryParse(valueRangePointer.toString())!,
                    cornerStyle: CornerStyle.bothCurve,
                    enableAnimation: true,
                    animationDuration: 2400,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: color ?? Colors.blueAccent,
                    width: 0.15),
              ]),
        ],
      ),
    );
  }
}
