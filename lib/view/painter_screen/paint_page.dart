import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paint_app/domain/entities/settings.dart';
import 'package:paint_app/view/painter_screen/settings_cubit/settings_cubit.dart';

import '../../domain/entities/drawing.dart';
import 'app_painter.dart';

class PaintPage extends StatefulWidget {
  const PaintPage({Key? key}) : super(key: key);

  @override
  _PaintPageState createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> {
  double strokeWidth = 2.0;
  Color drawColor = Colors.purple;

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
              child: StreamBuilder<SettingsState>(
                  stream:
                      BlocProvider.of<SettingsCubit>(context).settingsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final PaintSettings _paintSettings =
                          snapshot.data!.paintSettings;
                      return PaintCanvas(
                        drawColor: _paintSettings.drawColor,
                        strokeWidth: _paintSettings.strokeWidth,
                      );
                    }
                    return PaintCanvas(
                      drawColor: Colors.black,
                      strokeWidth: 2,
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
                      onPressed: () => BlocProvider.of<SettingsCubit>(context)
                          .changeSettings(PaintSettings(
                        drawColor: Colors.black,
                        strokeWidth: 2,
                      )),
                      child: Text('crna'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => BlocProvider.of<SettingsCubit>(context)
                          .changeSettings(PaintSettings(
                        drawColor: Colors.red,
                        strokeWidth: 2,
                      )),
                      child: Text('crvena'),
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
  final List<DrawPoint> initialdrawPoints;
  final double strokeWidth;
  final Color drawColor;

  const PaintCanvas({
    Key? key,
    this.initialdrawPoints = const [],
    required this.drawColor,
    required this.strokeWidth,
  }) : super(key: key);

  @override
  _PaintCanvasState createState() => _PaintCanvasState();
}

class _PaintCanvasState extends State<PaintCanvas> {
  List<Offset> drawPoints = [];

  @override
  void initState() {
    super.initState();
    drawPoints = List.from(widget.initialdrawPoints);
  }

  void addPoint(Offset newPoint) {
    setState(() {
      drawPoints.add(newPoint);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return CustomPaint(
      isComplex: true,
      foregroundPainter: AppPainter(
        drawing: Drawing(
          canvasPaths: [],
        ),
      ),
      child: GestureDetector(
        onPanStart: (det) => addPoint(
          Offset(det.localPosition.dx, det.localPosition.dy),
        ),
        onPanEnd: (det) => addPoint(
          Offset(-10, -10),
        ),
        onPanUpdate: (det) => addPoint(
          Offset(det.localPosition.dx, det.localPosition.dy),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: _size.height,
            maxWidth: _size.width,
          ),
          color: Colors.white,
        ),
      ),
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
