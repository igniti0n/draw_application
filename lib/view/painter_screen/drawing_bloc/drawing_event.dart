part of 'drawing_bloc.dart';

abstract class DrawingEvent extends Equatable {
  const DrawingEvent();

  @override
  List<Object> get props => [];
}

class SaveDrawing extends DrawingEvent {}

class PreviousDrawing extends DrawingEvent {}

class NextDrawing extends DrawingEvent {}

class Undo extends DrawingEvent {}

class UpdateDrawing extends DrawingEvent {
  final CanvasPath canvasPath;
  const UpdateDrawing(this.canvasPath);
}

class StartDrawing extends DrawingEvent {
  final CanvasPath canvasPath;
  const StartDrawing(this.canvasPath);
}
