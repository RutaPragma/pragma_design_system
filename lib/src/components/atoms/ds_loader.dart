import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// Loader circular personalizado con texto animado.
///
/// Muestra un círculo externo giratorio tipo “sombra”, con texto centrado animado.
/// Ideal para pantallas de carga en e-commerce.
///
/// Ejemplo:
/// ```dart
/// const DSLoader(label: 'Cargando productos');
/// ```
class DSLoader extends StatefulWidget {
  final double size;
  final Color? color;
  final Duration duration;
  final String? label;

  const DSLoader({
    super.key,
    this.size = DSSizesFoundations.iconSizeSmall,
    this.color,
    this.duration = const Duration(seconds: 2),
    this.label,
  });

  @override
  State<DSLoader> createState() => _DSLoaderState();
}

class _DSLoaderState extends State<DSLoader> with TickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final AnimationController _textController;
  late final AnimationController _controller;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();

    // Controla la rotación del anillo exterior
    _rotationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
    // Controla la animación de puntos suspensivos del texto
    _textController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 700),
        )..addListener(() {
          if (_textController.status == AnimationStatus.completed) {
            setState(() => _dotCount = (_dotCount + 1) % 4);
            _textController.forward(from: 0);
          }
        });

    _textController.forward();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _textController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color loaderColor = widget.color ?? DSColorsFoundations.brandPrimary;
    final String text = widget.label ?? "Load";
    final String dots = "." * _dotCount;

    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Círculo giratorio (externo)
            AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationController.value * 0.01 * math.pi,
                  child: CustomPaint(
                    size: Size(widget.size, widget.size),
                    painter: _LoaderPainter(
                      progress: _controller.value,
                      color: loaderColor,
                    ),
                  ),
                );
              },
            ),

            // Texto centrado con animación de puntos
            Text(
              "$text$dots",
              textAlign: TextAlign.center,
              style: DSTypographyFoundations.bodyMedium.copyWith(
                color: DSColorsFoundations.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoaderPainter extends CustomPainter {
  final double progress;
  final Color color;

  _LoaderPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    // Fondo suave
    paint.color = color.withValues(alpha: 0.05);
    canvas.drawCircle(center, radius * 1.2, paint);

    // // Tres esferas orbitando
    // for (int i = 0; i < 2; i++) {
    //   final double angle = (progress * 2 * math.pi) + (i * 2 * math.pi / 3);
    //   final double orbitRadius = radius * 0.4;
    //   final double x = center.dx + orbitRadius * math.cos(angle);
    //   final double y = center.dy + orbitRadius * math.sin(angle);

    //   // paint.color = Colors.transparent;
    //   paint.color = color.withValues(
    //     alpha: 0.01 + 0.01 * math.sin(progress * 8 * math.pi + i),
    //   );
    //   canvas.drawCircle(Offset(x, y), radius * .7, paint);
    // }

    // Pulso central
    paint.color = color.withValues(alpha: 0.6);
    final double scale = 1 + 0.2 * math.sin(progress * 2 * math.pi);
    canvas.drawCircle(center, radius * 1.2 * scale, paint);
  }

  @override
  bool shouldRepaint(covariant _LoaderPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
