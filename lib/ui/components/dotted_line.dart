import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double width;
  final double height;
  final double dashWidth;
  final double dashSpace;
  final Color color;

  const DottedLine({
    Key? key,
    this.width = double.infinity,
    this.height = 1.0,
    this.dashWidth = 4.0,
    this.dashSpace = 4.0,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth =
            width == double.infinity ? constraints.maxWidth : width;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
