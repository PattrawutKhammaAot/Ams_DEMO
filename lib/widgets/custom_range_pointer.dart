import 'package:ams_count/config/app_constants.dart';
import 'package:ams_count/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CustomRangePoint extends StatelessWidget {
  const CustomRangePoint(
      {super.key,
      required this.valueRangePointer,
      required this.allItem,
      this.color,
      this.text});
  final double? valueRangePointer;
  final double? allItem;

  final Color? color;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
              minimum: 0,
              maximum: allItem!,
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 1,
              axisLineStyle: const AxisLineStyle(
                  thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    angle: 60,
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "${valueRangePointer?.toInt() ?? "-"}",
                              style: TextStyle(
                                  fontFamily: 'Times',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic),
                            ),
                            Text(
                              ' / ${allItem?.toInt() ?? "-"}',
                              style: TextStyle(
                                  fontFamily: 'Times',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        Label(
                          "${text}",
                          color: colorPrimary,
                        )
                      ],
                    )),
              ],
              pointers: <GaugePointer>[
                RangePointer(
                    value: valueRangePointer!,
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
