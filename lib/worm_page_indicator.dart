import 'package:flutter/material.dart';

class WarmPageIndicatorPainter extends CustomPainter {
  final int pageCount;
  final double dotRadius;
  final double dotOutlineThickness;
  final Paint dotFillPaint;
  final Paint dotOutlinePaint;
  final Paint indicatorPaint;
  final double spaceNumberBetweenDots;
  final double scrollPosition;

  WarmPageIndicatorPainter({
    required this.pageCount,
    required this.dotRadius,
    required this.dotOutlineThickness,
    required Color dotFillColor,
    required Color dotOutlineColor,
    required Color indicatorColor,
    required this.spaceNumberBetweenDots,
    this.scrollPosition = 0.0,
  })  : dotFillPaint = Paint()..color = dotFillColor,
        dotOutlinePaint = Paint()..color = dotOutlineColor,
        indicatorPaint = Paint()..color = indicatorColor;
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double totalWith = (pageCount * (2 * dotRadius) + ((pageCount - 1) * spaceNumberBetweenDots));
    _drawDots(canvas, center, totalWith);
    _drawPageIndicator(canvas, center, totalWith);
  }

  void _drawPageIndicator(Canvas canvas, Offset center, double totalWith) {
    final int pageIndexToLeft = scrollPosition.floor();
    final double leftDotX =
        (center.dx - (totalWith / 2)) + (pageIndexToLeft * ((2 * dotRadius) + spaceNumberBetweenDots));
    final double transitionPercent = scrollPosition - pageIndexToLeft;

    final double laggingLeftPositionPercent = (transitionPercent - 0.3).clamp(0.0, 1.0) / 0.7;
    final double indicatorLeftX = leftDotX + (laggingLeftPositionPercent * ((2 * dotRadius) + spaceNumberBetweenDots));

    final double accelerateRightPositionPercent = (transitionPercent / 0.5).clamp(0.0, 1.0);
    final double indicatorRigthX =
        leftDotX + (accelerateRightPositionPercent * ((2 * dotRadius) + spaceNumberBetweenDots)) + (2 * dotRadius);

    canvas.drawRRect(
      RRect.fromLTRBR(
        indicatorLeftX,
        -dotRadius + 20,
        indicatorRigthX,
        dotRadius + 20,
        Radius.circular(dotRadius),
      ),
      indicatorPaint,
    );
  }

  void _drawDots(Canvas canvas, Offset center, double totalWith) {
    Offset dotCenter = center.translate((-totalWith / 2) + dotRadius, 20);
    for (var i = 0; i < pageCount; i++) {
      _drawDot(canvas, dotCenter);
      dotCenter = dotCenter.translate(((2 * dotRadius) + spaceNumberBetweenDots), 0);
    }
  }

  void _drawDot(Canvas canvas, Offset dotCenter) {
    canvas.drawCircle(dotCenter, dotRadius - dotOutlineThickness, dotFillPaint);
    Path outlinePath = Path()
      ..addOval(Rect.fromCircle(center: dotCenter, radius: dotRadius))
      ..addOval(Rect.fromCircle(center: dotCenter, radius: dotRadius - dotOutlineThickness))
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(outlinePath, dotOutlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
