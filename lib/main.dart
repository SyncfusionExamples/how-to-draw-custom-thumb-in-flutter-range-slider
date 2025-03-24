
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

void main() {
  return runApp(const MaterialApp(home: RangeSliderDemo()));
}

class RangeSliderDemo extends StatefulWidget {
  const RangeSliderDemo({super.key});

  @override
  RangeSliderDemoState createState() => RangeSliderDemoState();
}

class RangeSliderDemoState extends State<RangeSliderDemo> {
  SfRangeValues _values = const SfRangeValues(3000.0, 17000.0);
  final double _min = 0.0;
  final double _max = 20000.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side value display
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        '${_values.start.toInt()}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Right side value display
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        '${_values.end.toInt()}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              // Slider
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: SfRangeSliderTheme(
                  data: SfRangeSliderThemeData(
                    activeTrackColor: Colors.red,
                    inactiveTrackColor: Colors.grey[300],
                    trackCornerRadius: 0,
                    activeTrackHeight: 4,
                    inactiveTrackHeight: 4,
                    thumbColor: Colors.grey[300],
                    overlayRadius: 0.0,
                  ),
                  child: SfRangeSlider(
                    min: _min,
                    max: _max,
                    values: _values,
                    thumbShape: _CustomRangeThumbShape(),
                    onChanged: (SfRangeValues values) {
                      setState(() {
                        _values = values;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomRangeThumbShape extends SfThumbShape {
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required RenderBox? child,
    required SfSliderThemeData themeData,
    SfRangeValues? currentValues,
    dynamic currentValue,
    required Paint? paint,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required SfThumb? thumb,
  }) {
    final Canvas canvas = context.canvas;

    // Size of the rectangular thumb
    final double thumbWidth = 15;
    final double thumbHeight = 25;

    // Draw main thumb rectangle
    final Paint thumbPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Rect thumbRect = Rect.fromCenter(
      center: center,
      width: thumbWidth,
      height: thumbHeight,
    );

    // Draw white rectangle with shadow effect
    canvas.drawRRect(
      RRect.fromRectAndRadius(thumbRect, Radius.circular(3)),
      thumbPaint,
    );

    // Add subtle border around the thumb
    final Paint borderPaint = Paint()
      ..color = Colors.grey[400]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(thumbRect, Radius.circular(3)),
      borderPaint,
    );

    // Draw the three horizontal lines inside the thumb
    final Paint linePaint = Paint()
      ..color = Colors.grey[600]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final double lineSpacing = 4.0;
    final double lineWidth = 8.0;

    for (int i = 0; i < 3; i++) {
      final double yOffset = center.dy + (i - 1) * lineSpacing;
      canvas.drawLine(
        Offset(center.dx - lineWidth / 2, yOffset),
        Offset(center.dx + lineWidth / 2, yOffset),
        linePaint,
      );
    }
  }

  @override
  Size getPreferredSize(SfSliderThemeData themeData) {
    return Size(20.0, 30.0); // Width and height of the thumb
  }
}
