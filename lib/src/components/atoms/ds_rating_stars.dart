import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Átomo: componente visual para mostrar calificaciones mediante estrellas.
///
/// Ejemplo de uso:
/// ```dart
/// DSRatingStars(
///   rating: 4.5,
///   onChanged: (value) => print("Nuevo valor: $value"),
/// )
/// ```
class DSRatingStars extends StatelessWidget {
  final double rating; // Valor actual, puede tener decimales (ej. 4.5)
  final int maxStars; // Total de estrellas
  final double size; // Tamaño de cada estrella
  final Color? filledColor; // Color de estrella llena
  final Color? emptyColor; // Color de estrella vacía
  final Color? halfColor; // Color de estrella media
  final bool isInteractive; // Si el usuario puede cambiar la calificación
  final ValueChanged<double>? onChanged;

  const DSRatingStars({
    super.key,
    required this.rating,
    this.maxStars = 5,
    this.size = DSSizesFoundations.iconSizeMedium,
    this.filledColor,
    this.emptyColor,
    this.halfColor,
    this.isInteractive = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color filled =
        filledColor ??
        (isDark
            ? DSColorsFoundations.brandSecondaryDark
            : DSColorsFoundations.brandSecondary);
    final Color empty =
        emptyColor ??
        (isDark
            ? DSColorsFoundations.textHintDark
            : DSColorsFoundations.textHint);
    final Color half =
        halfColor ??
        (isDark
            ? DSColorsFoundations.brandPrimaryDark
            : DSColorsFoundations.brandPrimary);

    final stars = List.generate(maxStars, (index) {
      final starValue = index + 1;
      if (rating >= starValue) {
        // Estrella llena
        return _buildStar(context, Icons.star_rounded, filled, starValue);
      } else if (rating > starValue - 1 && rating < starValue) {
        // Estrella media
        return _buildStar(context, Icons.star_half_rounded, half, starValue);
      } else {
        // Estrella vacía
        return _buildStar(context, Icons.star_border_rounded, empty, starValue);
      }
    });

    return Row(
      key: const ValueKey("dsRatingStarsRow"),
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }

  Widget _buildStar(
    BuildContext context,
    IconData icon,
    Color color,
    int value,
  ) {
    final star = Icon(
      icon,
      key: ValueKey("dsRatingStar_$value"),
      color: color,
      size: size,
    );

    if (!isInteractive) return star;

    return GestureDetector(
      key: ValueKey("dsRatingStarGesture_$value"),
      onTap: () => onChanged?.call(value.toDouble()),
      child: star,
    );
  }
}
