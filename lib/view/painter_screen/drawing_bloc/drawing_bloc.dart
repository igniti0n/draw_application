import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paint_app/domain/entities/canvas_path.dart';
import 'package:paint_app/domain/entities/drawing.dart';

part 'drawing_event.dart';
part 'drawing_state.dart';

class DrawingBloc extends Bloc<DrawingEvent, DrawingState> {
  DrawingBloc() : super(DrawingInitial(const []));

  Drawing _drawing = Drawing(canvasPaths: []);

  @override
  Stream<DrawingState> mapEventToState(
    DrawingEvent event,
  ) async* {
    //log("DRAWING event:" + event.toString());
    if (event is UpdateDrawing) {
      yield DrawingLoading(_drawing.canvasPaths);
      _drawing.canvasPaths.last = event.canvasPath;
      yield DrawingLoaded(_drawing.canvasPaths);
    } else if (event is StartDrawing) {
      yield DrawingLoading(_drawing.canvasPaths);
      _drawing.canvasPaths.add(event.canvasPath);
      yield DrawingLoaded(_drawing.canvasPaths);
    } else if (event is Undo) {
      if (_drawing.canvasPaths.isNotEmpty) {
        yield DrawingLoading(_drawing.canvasPaths);
        _drawing.canvasPaths.removeLast();
        yield DrawingLoaded(_drawing.canvasPaths);
      }
    }
  }
}
