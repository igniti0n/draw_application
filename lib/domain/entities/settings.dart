import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PaintSettings extends Equatable {
  final double strokeWidth;
  final Color drawColor;
  const PaintSettings({
    required this.drawColor,
    required this.strokeWidth,
  });

  @override
  List<Object?> get props => [this.drawColor, this.strokeWidth];
}
