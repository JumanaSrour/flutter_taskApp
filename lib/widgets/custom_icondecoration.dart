import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomIconDecoration extends Decoration {
  final double iconSize;
  final double lineWidth;
  final bool firstDate;
  final bool lastDate;
  CustomIconDecoration({
    @override double iconSize,
    @override double lineWidth,
    @override bool firstDate,
    @override bool lastDate,
  })  : this.iconSize = iconSize,
        this.lineWidth = lineWidth,
        this.firstDate = firstDate,
        this.lastDate = lastDate;

  @override
  BoxPainter createBoxPainter([onChanged]) {
    return IconLine(
        iconSize: iconSize,
        lineWidth: lineWidth,
        firstDate: firstDate,
        lastDate: lastDate);
  }
}

class IconLine extends BoxPainter {
  final double iconSize;
  final bool firstDate;
  final bool lastDate;
  final Paint paintLine;
  IconLine({
    @override double iconSize,
    @override double lineWidth,
    @override bool firstDate,
    @override bool lastDate,
  })  : this.iconSize = iconSize,
        this.firstDate = firstDate,
        this.lastDate = lastDate,
        paintLine = Paint()
          ..color = Colors.deepPurple
          ..strokeCap = StrokeCap.round
          ..strokeWidth = lineWidth
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final leftOffset = Offset((iconSize / 2) * 3.5, offset.dy);
    final double iconSpace = iconSize / 1.5;
    final Offset top = configuration.size.topLeft(Offset(leftOffset.dx, 0.0));
    final Offset centerTop = configuration.size
        .centerLeft(Offset(leftOffset.dx, leftOffset.dy - iconSpace));
    final Offset centerBottom = configuration.size
        .centerLeft(Offset(leftOffset.dx, leftOffset.dy + iconSpace));
    final Offset end =
        configuration.size.bottomLeft(Offset(leftOffset.dx, leftOffset.dy * 2));
    if (!firstDate) canvas.drawLine(top, centerTop, paintLine);
    if (!lastDate) canvas.drawLine(centerBottom, end, paintLine);
  }
}
