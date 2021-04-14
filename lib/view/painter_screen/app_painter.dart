import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paint_app/domain/entities/canvas_path.dart';

import '../../domain/entities/drawing.dart';

class AppPainter extends CustomPainter {
  final Drawing drawing;

  AppPainter({
    required this.drawing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final List<CanvasPath> canvasPaths = drawing.canvasPaths;

    var _paint = Paint();

    if (canvasPaths.isNotEmpty) {
      canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

      //!draw all the paths
      canvasPaths.forEach((CanvasPath canvasPath) {
        if (canvasPath.drawPoints.isNotEmpty) {
          final Paint _currentPathSettings = canvasPath.paint;

          _paint = canvasPath.paint..style = PaintingStyle.stroke;

          //some value for radius based on experimenting lol
          final _raidus = math.sqrt(_currentPathSettings.strokeWidth) / 20;

          canvas.drawPath(canvasPath.path, _paint);

          if (_currentPathSettings.strokeWidth > 1)
            for (int i = 0; i < canvasPath.drawPoints.length - 1; i++) {
              // canvas.drawLine(canvasPath.drawPoints[i],
              //     canvasPath.drawPoints[i + 1], _paint);
              canvas.drawCircle(
                  canvasPath.drawPoints[i],
                  _currentPathSettings.strokeWidth < 1
                      ? _currentPathSettings.strokeWidth
                      : _raidus,
                  _paint);
            }
        }
      });
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant AppPainter oldDelegate) => true;
}
