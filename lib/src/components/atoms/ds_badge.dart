import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// DSBadge con soporte para forma clásica o de estrella.
///
/// - Si [isMedal] es `false`: muestra un badge clásico circular/rectangular.
/// - Si [isMedal] es `true`: dibuja una estrella decorativa con el texto centrado.
class DSBadge extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final double? size;
  final double? textSize;
  final bool isCircular;
  final bool isMedal;
  final VoidCallback? onTap;

  const DSBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.size,
    this.isCircular = true,
    this.isMedal = false,
    this.onTap,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    final double badgeSize = size ?? DSSizesFoundations.iconSizeSmall;
    final Color bgColor = backgroundColor ?? DSColorsFoundations.brandSecondary;
    final Color txtColor = textColor ?? DSColorsFoundations.textOnPrimary;

    if (isMedal) {
      return GestureDetector(
        onTap: onTap,
        child: CustomPaint(
          painter: _StarBadgePainter(
            color: bgColor,
            shadow: DSShadowsFoundations.shadowMedium,
          ),
          size: Size(badgeSize * 2, badgeSize * 2),
          child: SizedBox(
            width: badgeSize * 2,
            height: badgeSize * 2,
            child: Center(
              child: Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                style: DSTypographyFoundations.labelSmall.copyWith(
                  color: txtColor,
                  fontSize: textSize ?? badgeSize * 0.3,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: badgeSize,
        constraints: BoxConstraints(minWidth: badgeSize),
        padding: EdgeInsets.symmetric(
          horizontal: DSSizesFoundations.separatorSmall,
          vertical: DSSizesFoundations.separatorXS / 2,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(
            isCircular ? badgeSize : DSSizesFoundations.separatorSmall,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: DSTypographyFoundations.bodySmall.copyWith(
            color: txtColor,
            fontSize: textSize ?? badgeSize * 0.3,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// CustomPainter para dibujar una estrella decorativa.
/// Usado cuando DSBadge tiene [isMedal] = true.
class _StarBadgePainter extends CustomPainter {
  final Color color;
  final List<BoxShadow> shadow;

  _StarBadgePainter({required this.color, required this.shadow});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [color.withValues(alpha: 1), color.withValues(alpha: 0.85)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Agregar sombra
    for (final s in shadow) {
      final Paint shadowPaint = Paint()
        ..color = s.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, s.blurRadius);
      final Path starPath = _createStarPath(
        size.width / 2,
        size.height / 2,
        size.width / 2.2,
        5,
      );
      canvas.drawPath(
        starPath.shift(Offset(s.offset.dx, s.offset.dy)),
        shadowPaint,
      );
    }

    // Dibujar estrella
    final Path starPath = _createStarPath(
      size.width / 2.1,
      size.height / 2,
      size.width / 2.2,
      7,
    );
    canvas.drawPath(starPath, paint);

    // Agregar borde suave
    final Paint borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(starPath, borderPaint);
  }

  Path _createStarPath(double cx, double cy, double radius, int points) {
    final Path path = Path();
    final double innerRadius = radius / 1.8;
    final double angle = (2 * math.pi) / points;

    for (int i = 0; i < points * 2; i++) {
      final double r = i.isEven ? radius : innerRadius;
      final double x = cx + r * math.cos(i * angle / 2);
      final double y = cy + r * math.sin(i * angle / 2);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _StarBadgePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.shadow != shadow;
  }
}
