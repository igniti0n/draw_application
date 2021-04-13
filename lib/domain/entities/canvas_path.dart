import 'dart:developer' as dev;
import 'dart:math';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class CanvasPath extends Equatable {
  final Path path = Path();
  Paint paint;
  final List<Offset> drawPoints;
  CanvasPath({
    required this.paint,
    required this.drawPoints,
  });

  void movePathTo(double x, double y) {
    path.moveTo(x, y);
  }

  void makeLineTo(double x, double y) {
    path.lineTo(x, y);
    path.moveTo(x, y);
  }

  void quadric(double x, double y) {
    //calculate distance from last point
    final _distance =
        (sqrt(pow(x - drawPoints.last.dx, 2) + pow(y - drawPoints.last.dy, 2)));

    dev.log("distance:    " + _distance.toString());

    if (_distance > 0.8)
      // path.arcToPoint(Offset(x, y));
      path.quadraticBezierTo(drawPoints.last.dx, drawPoints.last.dy, x, y);
    else
      path.moveTo(x, y);
  }

  // void addLastPointBasedOnVelocity(Velocity velocity) {
  //   // final Offset lastOffset = velocity.pixelsPerSecond;
  //   path.quadraticBezierTo(drawPoints.last.dx, drawPoints.last.dy,
  //       drawPoints.last.dx + 2, drawPoints.last.dy + 2);
  // }

  void setDrawPoints() {}

  @override
  List<Object?> get props => [paint];
}
