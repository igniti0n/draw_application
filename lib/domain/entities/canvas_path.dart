import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:paint_app/domain/entities/settings.dart';

class CanvasPath extends Equatable {
  final Path path;
  final PaintSettings paintSettings;
  const CanvasPath({
    required this.paintSettings,
    required this.path,
  });

  void movePathTo(double x, double y) {
    path.moveTo(x, y);
  }

  void makeLineTo(double x, double y) {
    path.lineTo(x, y);
  }

  @override
  List<Object?> get props => [paintSettings];
}
