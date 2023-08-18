import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CustomRangePoint extends StatelessWidget {
  const CustomRangePoint(
      {super.key, required this.valueRangePointer, required this.allItem});
  final double? valueRangePointer;
  final double? allItem;

  @override
  Widget build(BuildContext context) {
    print(valueRangePointer);
    print(allItem);
    return Container(
      width: 70,
      height: 50,
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
              radiusFactor: 1.3,
              axisLineStyle: const AxisLineStyle(
                  thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    angle: 60,
                    widget: Row(
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
                    )),
              ],
              pointers: <GaugePointer>[
                RangePointer(
                    value: valueRangePointer!,
                    cornerStyle: CornerStyle.bothCurve,
                    enableAnimation: true,
                    animationDuration: 2400,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: Colors.blueAccent,
                    width: 0.15),
              ]),
        ],
      ),
    );
  }
}
