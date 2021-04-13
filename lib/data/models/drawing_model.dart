import '../../domain/entities/canvas_path.dart';
import '../../domain/entities/drawing.dart';

class DrawingModel extends Drawing {
  DrawingModel({
    required List<CanvasPath> canvasPaths,
  }) : super(
          canvasPaths: canvasPaths,
        );

  factory DrawingModel.fromJson(Map<String, dynamic> map) {
    return DrawingModel(
      canvasPaths: map['canvasPaths'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'canvasPaths': this.canvasPaths,
    };
  }
}
