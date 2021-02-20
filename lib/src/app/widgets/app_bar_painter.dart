import 'dart:math';

import 'package:flutter/material.dart';

class AppBarPainter extends CustomPainter {
  AppBarPainter({@required this.color, @required this.curveRadius});

  static const double _margin = 6;
  final Color color;
  final double curveRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds =
        Rect.fromLTWH(0, 0, size.width, size.height - curveRadius);

    final avatarRect =
        Rect.fromPoints(Offset(0, 75), Offset(size.width, size.height / 2.5))
            .inflate(_margin);

    _drawBackground(canvas, shapeBounds, avatarRect);
  }

  void _drawBackground(Canvas canvas, Rect bounds, Rect avatarRect) {
    final paint = Paint()..color = color;

    final backgroundPath = Path()
      ..moveTo(bounds.left, bounds.top)
      ..lineTo(bounds.bottomLeft.dx, bounds.bottomLeft.dy)
      ..arcTo(avatarRect, -pi, pi, false)
      ..lineTo(bounds.bottomRight.dx, bounds.bottomRight.dy)
      ..lineTo(bounds.topRight.dx, bounds.topRight.dy)
      ..close();

    canvas.drawPath(backgroundPath, paint);
  }

  @override
  bool shouldRepaint(AppBarPainter oldDelegate) {
    return curveRadius != oldDelegate.curveRadius || color != oldDelegate.color;
  }
}

extension ColorShades on Color {
  Color darker() {
    const int darkness = 10;
    int r = (red - darkness).clamp(0, 255);
    int g = (green - darkness).clamp(0, 255);
    int b = (blue - darkness).clamp(0, 255);
    return Color.fromRGBO(r, g, b, 1);
  }
}
