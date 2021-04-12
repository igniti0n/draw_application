import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:paint_app/domain/entities/canvas_path.dart';

class Drawing extends Equatable {
  final List<CanvasPath> canvasPaths;

  const Drawing({
    required this.canvasPaths,
  });

  @override
  List<Object?> get props => [this.canvasPaths];
}
