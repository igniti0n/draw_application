import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paint_app/domain/entities/canvas_path.dart';
import 'package:paint_app/view/painter_screen/drawing_bloc/drawing_bloc.dart';
import 'package:paint_app/view/painter_screen/settings_bloc/settings_bloc.dart';

import '../../domain/entities/drawing.dart';
import 'app_painter.dart';

class PaintPage extends StatelessWidget {
  // double strokeWidth = 2.0;
  // Color drawColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    //  log(drawPoints.toString());

    return Scaffold(
      // bottomSheet: Container(
      //   height: 200,
      //   color: Colors.blueGrey,
      // ),
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
              // StreamBuilder<PathsState>(
              //     stream: BlocProvider.of<PathsCubit>(context).settingsStream,
              //     builder: (context, snapshot) {
              //       log("data changed: ${snapshot.data}");
              //       log("connection state: ${snapshot.connectionState}");
              //       if (snapshot.hasData) {
              //         return PaintCanvas(
              //           initialdrawPoints: snapshot.data!.canvasPaths,
              //         );
              //       }
              //       return PaintCanvas(
              //         initialdrawPoints: snapshot.data == null
              //             ? []
              //             : snapshot.data!.canvasPaths,
              //       );
              //     }),
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
                        SettingsColorChanged(Colors.black),
                      ),
                      child: Text('crna'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          BlocProvider.of<SettingsBloc>(context).add(
                        SettingsColorChanged(Colors.red),
                      ),
                      child: Text('crvena'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          BlocProvider.of<SettingsBloc>(context).add(
                        SettingsStrokeWidthChanged(50),
                      ),
                      child: Text('width 20'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          BlocProvider.of<SettingsBloc>(context).add(
                        SettingsStrokeWidthChanged(10),
                      ),
                      child: Text('width 10'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          BlocProvider.of<DrawingBloc>(context).add(
                        Undo(),
                      ),
                      child: Text('undo'),
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
  Paint _currentPaintSettings = Paint();

  CanvasPath _newPath = CanvasPath(
    paint: Paint(),
    drawPoints: [],
  );

  void addPoint(Offset newPoint) {
    _newPath.quadric(newPoint.dx, newPoint.dy);
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
