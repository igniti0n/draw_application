import 'package:flutter/material.dart';
import 'package:paint_app/domain/entities/draw_point.dart';
import 'package:paint_app/domain/entities/drawing.dart';

class DrawingModel extends Drawing {
  DrawingModel({
    required List<DrawPoint> drawPoints,
  }) : super(
          drawPoints: drawPoints,
        );

  factory DrawingModel.fromJson(Map<String, dynamic> map) {
    return DrawingModel(
      drawPoints: map['drawPoints'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'drawPoints': this.drawPoints,
    };
  }
}
