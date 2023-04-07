import 'package:flutter/material.dart';

class ImageWithPointsPainter extends CustomPainter {
  final List<Offset> _points;
  Paint? _linePaint, _pointPaint;

  ImageWithPointsPainter(this._points) {
    _linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    _pointPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _points.length; i++) {
      final Offset point = _points[i];
      canvas.drawCircle(point, 8.0, _pointPaint!);
      canvas.drawLine(point, _points[(i + 1) % _points.length], _linePaint!);
    }
  }

  @override
  bool shouldRepaint(ImageWithPointsPainter oldDelegate) {
    return oldDelegate._points != _points;
  }
}
