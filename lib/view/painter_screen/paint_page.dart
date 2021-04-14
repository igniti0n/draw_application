import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paint_app/domain/entities/canvas_path.dart';
import 'package:paint_app/view/painter_screen/drawing_bloc/drawing_bloc.dart';
import 'package:paint_app/view/painter_screen/settings_bloc/settings_bloc.dart';

import '../../domain/entities/drawing.dart';
import 'app_painter.dart';

class PaintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ClipPath(
              clipper: CanvasClipper(),
              child:
                  BlocBuilder<DrawingBloc, DrawingState>(builder: (ctx, state) {
                //log("Drawing bloc state:" + state.toString());
                return PaintCanvas(
                  initialdrawPoints: state.currentDrawing,
                );
              }),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 40,
            ),
            child: Container(
              color: Colors.blueGrey,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          BlocProvider.of<SettingsBloc>(context).add(
                        SettingsChanged(
                          Paint()
                            ..color = Colors.black
                            ..blendMode = BlendMode.srcOver,
                        ),
                      ),
                      child: Text('black'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          BlocProvider.of<SettingsBloc>(context).add(
                        SettingsChanged(
                          Paint()
                            ..color = Colors.red
                            ..blendMode = BlendMode.srcOver,
                        ),
                      ),
                      child: Text('red'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          BlocProvider.of<SettingsBloc>(context).add(
                        SettingsChanged(
                          Paint()..blendMode = BlendMode.clear,
                        ),
                      ),
                      child: Text('erase'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<SettingsBloc>(context)
                            .add(SettingsStrokeWidthChanged(-0.5));
                      },
                      child: Text('-0.5'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<SettingsBloc>(context)
                            .add(SettingsStrokeWidthChanged(0.5));
                      },
                      child: Text('+0.5'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          BlocProvider.of<DrawingBloc>(context).add(
                        Undo(),
                      ),
                      child: Text('Undo'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PaintCanvas extends StatefulWidget {
  final List<CanvasPath> initialdrawPoints;

  const PaintCanvas({
    Key? key,
    this.initialdrawPoints = const [],
  }) : super(key: key);

  @override
  _PaintCanvasState createState() => _PaintCanvasState();
}

class _PaintCanvasState extends State<PaintCanvas> {
  Paint _currentPaintSettings = Paint()
    ..strokeWidth = 1
    ..color = Colors.black;

  CanvasPath _newPath = CanvasPath(
    paint: Paint()
      ..strokeWidth = 1
      ..color = Colors.black,
    drawPoints: [],
  );

  void addPoint(Offset newPoint) {
    _newPath.quadric(
      newPoint.dx,
      newPoint.dy,
    );
    _newPath.drawPoints.add(newPoint);
    BlocProvider.of<DrawingBloc>(context).add(UpdateDrawing(_newPath));
  }

  void addLastPoint() {
    final Offset _lastOffset = _newPath.drawPoints.last;

    final Offset _additionalOffset =
        Offset(_lastOffset.dx + 10, _lastOffset.dy + 10);

    _newPath.drawPoints.add(_additionalOffset);
    BlocProvider.of<DrawingBloc>(context).add(UpdateDrawing(_newPath));
  }

  Paint _paintFrom(Paint paint) {
    return Paint()
      ..color = paint.color
      ..strokeWidth = paint.strokeWidth
      ..blendMode = paint.blendMode
      ..strokeCap = paint.strokeCap
      ..shader = paint.shader;
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _drawingBloc = BlocProvider.of<DrawingBloc>(context);

    return BlocBuilder<DrawingBloc, DrawingState>(
      builder: (context, state) {
        return CustomPaint(
          isComplex: true,
          willChange: true,
          foregroundPainter: AppPainter(
            drawing: Drawing(
              canvasPaths: state.currentDrawing,
            ),
          ),
          child: BlocListener<SettingsBloc, SettingsState>(
            listener: (context, state) {
              _currentPaintSettings = state.paintSettings;
            },
            child: GestureDetector(
              onPanStart: (det) {
                _newPath = CanvasPath(
                    paint: _paintFrom(_currentPaintSettings),
                    drawPoints: [
                      det.localPosition,
                    ]);
                _newPath.movePathTo(det.localPosition.dx, det.localPosition.dy);

                _drawingBloc.add(StartDrawing(_newPath));
              },
              onPanUpdate: (det) => addPoint(
                Offset(det.localPosition.dx, det.localPosition.dy),
              ),
              onPanEnd: (det) => addLastPoint(),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: _size.height,
                  maxWidth: _size.width,
                ),
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

class CanvasClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final _path = Path();
    _path.moveTo(0, 0);
    _path.lineTo(size.width, 0);

    _path.lineTo(size.width, size.height);

    _path.lineTo(0, size.height);
    _path.close();
    return _path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
