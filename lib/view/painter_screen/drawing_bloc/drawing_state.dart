part of 'drawing_bloc.dart';

abstract class DrawingState extends Equatable {
  const DrawingState(this.currentDrawing);
  final List<CanvasPath> currentDrawing;

  @override
  List<Object> get props => [currentDrawing];
}

class DrawingInitial extends DrawingState {
  DrawingInitial(List<CanvasPath> currentDrawing) : super(currentDrawing);
}

class DrawingLoading extends DrawingState {
  DrawingLoading(List<CanvasPath> currentDrawing) : super(currentDrawing);
}

class DrawingLoaded extends DrawingState {
  DrawingLoaded(List<CanvasPath> currentDrawing) : super(currentDrawing);
}
