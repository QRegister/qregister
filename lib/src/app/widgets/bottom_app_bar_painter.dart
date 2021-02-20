import 'dart:math';

import 'package:flutter/material.dart';

class BottomAppBarPainter extends CustomPainter {
  BottomAppBarPainter(
      {@required this.color, @required this.selectedItemRadius});

  static const double _margin = 6;
  final Color color;
  final double selectedItemRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds = Rect.fromLTWH(
        0, size.height - 60, size.width, size.height - selectedItemRadius);

    final centerAvatar = Offset(shapeBounds.center.dx, shapeBounds.top);
    final avatarRect =
        Rect.fromCircle(center: centerAvatar, radius: selectedItemRadius)
            .inflate(_margin);

    _drawBackground(canvas, shapeBounds, avatarRect);
  }

  void _drawBackground(Canvas canvas, Rect bounds, Rect avatarRect) {
    final paint = Paint()..color = color;

    final backgroundPath = Path()
      ..moveTo(bounds.left, bounds.bottom)
      ..lineTo(bounds.topLeft.dx, bounds.topLeft.dy)
      ..arcTo(avatarRect, pi, -pi, false)
      ..lineTo(bounds.topRight.dx, bounds.topRight.dy)
      ..lineTo(bounds.bottomRight.dx, bounds.bottomRight.dy)
      ..close();

    canvas.drawPath(backgroundPath, paint);
  }

  @override
  bool shouldRepaint(BottomAppBarPainter oldDelegate) {
    return selectedItemRadius != oldDelegate.selectedItemRadius ||
        color != oldDelegate.color;
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
