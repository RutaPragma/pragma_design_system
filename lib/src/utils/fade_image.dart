import 'package:flutter/material.dart';

/// Widget que muestra una imagen que se "desvanece" (fade) hacia la transparencia.
/// - [image]: ImageProvider (AssetImage, NetworkImage, etc.)
/// - [height]: alto del contenedor (puede ser null para dejar flexible)
/// - [fadeStart]: porcentaje (0..1) del inicio del fade desde el borde donde comienza.
/// - [fadeEnd]: porcentaje (0..1) donde termina el fade (usualmente 1.0)
/// - [vertical]: si true el fade es vertical (bottom -> top), si false es horizontal (left -> right)
class FadeImage extends StatelessWidget {
  final ImageProvider image;
  final double? height;
  final double fadeStart;
  final double fadeEnd;
  final bool vertical;
  final BoxFit fit;
  final Alignment alignment;
  final Color fadeColor;

  const FadeImage({
    super.key,
    required this.image,
    required this.fadeColor,
    this.height,
    this.fadeStart = 0.6, // comienza el fade al 60% del eje
    this.fadeEnd = 1.0, // termina al 100% del eje (completamente transparente)
    this.vertical = true,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  }) : assert(fadeStart >= 0 && fadeStart <= 1),
       assert(fadeEnd >= 0 && fadeEnd <= 1),
       assert(fadeStart <= fadeEnd);

  @override
  Widget build(BuildContext context) {
    // Gradient para aplicar sobre la máscara alfa de la imagen
    final gradient = LinearGradient(
      begin: vertical ? Alignment.topCenter : Alignment.centerLeft,
      end: vertical ? Alignment.bottomCenter : Alignment.centerRight,
      colors: [
        fadeColor, // zona completamente opaca (imagen visible)
        fadeColor.withValues(alpha: 0.6), // mantener opaco hasta fadeStart
        Colors.transparent, // empezar a desvanecer
      ],
      stops: [0.0, fadeStart, fadeEnd],
    );

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ShaderMask(
        shaderCallback: (rect) {
          return gradient.createShader(rect);
        },
        blendMode:
            BlendMode.dstIn, // importante: aplica el gradient como máscara alfa
        child: Image(
          image: image,
          fit: fit,
          alignment: alignment,
          width: double.infinity,
          height: height,
        ),
      ),
    );
  }
}
