import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: PaintPage(),
    );
  }
}

class PaintPage extends StatefulWidget {
  const PaintPage({Key? key}) : super(key: key);

  @override
  _PaintPageState createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> {
  double strokeWidth = 2.0;
  Color drawColor = Colors.purple;
  List<Offset> drawPoints = [];

  void addPoint(Offset newPoint) {
    setState(() {
      drawPoints.add(newPoint);
    });
  }

  @override
  Widget build(BuildContext context) {
    //  log(drawPoints.toString());
    return Scaffold(
      body: CustomPaint(
        isComplex: true,
        foregroundPainter: AppPainter(
          drawColor: drawColor,
          drawPoints: drawPoints,
          strokeWidth: strokeWidth,
        ),
        child: GestureDetector(
          onPanStart: (det) =>
              addPoint(Offset(det.localPosition.dx, det.localPosition.dy)),
          onPanEnd: (det) => addPoint(Offset(-10, -10)),
          onPanUpdate: (det) =>
              addPoint(Offset(det.localPosition.dx, det.localPosition.dy)),
          child: Container(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class AppPainter extends CustomPainter {
  final List<Offset> drawPoints;
  final Color drawColor;
  final double strokeWidth;
  AppPainter({
    required this.drawColor,
    required this.drawPoints,
    required this.strokeWidth,
  });

  final _path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint()
      ..color = drawColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..blendMode = BlendMode.src;

    if (drawPoints.isNotEmpty) {
      _path.moveTo(
        drawPoints[0].dx,
        drawPoints[0].dy,
      );

      bool _shouldMovePath = false;

      drawPoints.forEach((Offset drawPoint) {
        if (_shouldMovePath) {
          _path.moveTo(drawPoint.dx, drawPoint.dy);
          _shouldMovePath = false;
        } else if (drawPoint.dx < 0) {
          _shouldMovePath = true;
        } else {
          _shouldMovePath = false;
          _path.lineTo(drawPoint.dx, drawPoint.dy);
        }
      });
    }

    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant AppPainter oldDelegate) {
    if (oldDelegate.drawPoints.length != this.drawPoints.length ||
        oldDelegate.drawColor != this.drawColor ||
        oldDelegate.strokeWidth != this.strokeWidth) return true;
    return true;
  }
}
