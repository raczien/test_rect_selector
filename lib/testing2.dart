import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainterDraggable extends StatefulWidget {
  @override
  _CustomPainterDraggableState createState() => _CustomPainterDraggableState();
}

class _CustomPainterDraggableState extends State<CustomPainterDraggable> {
  var xPos = 0.0;
  var yPos = 0.0;
  var width = 100.0;
  var height = 100.0;
  bool _dragging = false;

  /// Is the point (x, y) inside the rect?
  bool _insideRect(double x, double y) {
    if ((pow(xPos - x, 2) + pow(y - yPos, 2)) <= pow(height, width)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => _dragging = _insideRect(
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      onPanEnd: (details) {
        _dragging = false;
      },
      onPanUpdate: (details) {
        if (_dragging) {
          setState(() {
            xPos += details.delta.dx;
            yPos += details.delta.dy;
          });
        }
      },
      child: CustomPaint(
        painter: RectanglePainter(Rect.fromLTWH(xPos, yPos, width, height)),
        child: Container(),
      ),
    );
  }
}

class RectanglePainter extends CustomPainter {
  RectanglePainter(this.rect);
  final Rect rect;

  @override
  void paint(Canvas canvas, Size size) {
    Paint myPainter = Paint()..style = PaintingStyle.stroke;
    canvas.drawRect(rect, myPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
