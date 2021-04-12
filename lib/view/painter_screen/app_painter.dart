import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paint_app/domain/entities/canvas_path.dart';

import '../../domain/entities/drawing.dart';

class AppPainter extends CustomPainter {
  // final List<Offset> drawPoints;
  // final Color drawColor;
  // final double strokeWidth;
  final Drawing drawing;

  AppPainter({
    // required this.drawColor,
    // required this.drawPoints,
    // required this.strokeWidth,
    required this.drawing,
  });

  var _path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    // log("PAINTING");
    final List<CanvasPath> drawPoints = drawing.canvasPaths;

    final _paint = Paint();
    final _mousePressPaint = Paint();

    if (drawPoints.isNotEmpty) {
      drawPoints.forEach((CanvasPath canvasPath) {
        canvasPath.movePathTo(
          drawPoints[0].drawPoint.dx,
          drawPoints[0].drawPoint.dy,
        );
      });

      bool _shouldMovePath = false;

      _mousePressPaint
        ..color = drawPoints[0].drawColor
        ..strokeWidth = drawPoints[0].strokeWidth
        ..style = PaintingStyle.fill
        ..isAntiAlias = true
        ..blendMode = BlendMode.src;

      canvas.drawCircle(drawPoints[0].drawPoint, drawPoints[0].strokeWidth / 2,
          _mousePressPaint);

      drawPoints.forEach((DrawPoint drawPoint) {
        _paint
          ..color = drawPoint.drawColor
          ..strokeWidth = drawPoint.strokeWidth
          ..style = PaintingStyle.stroke
          ..isAntiAlias = true
          ..blendMode = BlendMode.src;

        _mousePressPaint
          ..color = drawPoint.drawColor
          ..strokeWidth = drawPoint.strokeWidth
          ..style = PaintingStyle.fill
          ..isAntiAlias = true
          ..blendMode = BlendMode.src;

        if (_shouldMovePath) {
          _path.moveTo(drawPoint.drawPoint.dx, drawPoint.drawPoint.dy);
          canvas.drawCircle(
              drawPoint.drawPoint, drawPoint.strokeWidth / 2, _mousePressPaint);

          _shouldMovePath = false;
        } else if (drawPoint.drawPoint.dx < 0) {
          _shouldMovePath = true;
        } else {
          _shouldMovePath = false;
          _path.lineTo(drawPoint.drawPoint.dx, drawPoint.drawPoint.dy);
        }
      });
      canvas.drawPath(_path, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant AppPainter oldDelegate) {
    return true;
  }
}
