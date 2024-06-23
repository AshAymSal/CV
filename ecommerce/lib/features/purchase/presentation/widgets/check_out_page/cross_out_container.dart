import 'package:flutter/material.dart';

class CrossedOutContainer extends StatelessWidget {
  Widget child;
  bool isDeleted;

  CrossedOutContainer(this.child, this.isDeleted, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CrossedOutPainter(isDeleted),
      child: Container(
        child: child,
      ),
    );
  }
}

class _CrossedOutPainter extends CustomPainter {
  bool isDeleted;
  _CrossedOutPainter(this.isDeleted);
  @override
  void paint(Canvas canvas, Size size) {
    if (isDeleted) {
      Paint paint = Paint()
        ..color = Colors.red
        ..strokeWidth = 2.0;

      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
