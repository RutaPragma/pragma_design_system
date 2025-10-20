import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Átomo de conmutador (switch / toggle) del sistema de diseño.
///
/// Totalmente parametrizable, permite definir colores personalizados,
/// tamaños, etiquetas y comportamiento.
/// Usa por defecto la lógica de colores según el modo oscuro o claro.
///
/// Ejemplo de uso:
/// ```dart
/// DSToggle(
///   value: true,
///   onChanged: (val) => print('Nuevo valor: $val'),
///   label: 'Activo',
///   showLabel: true,
/// )
/// ```
class DSToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final bool showLabel;
  final double width;
  final double height;

  const DSToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.showLabel = false,
    this.width = 50,
    this.height = 28,
  });

  @override
  State<DSToggle> createState() => _DSToggleState();
}

class _DSToggleState extends State<DSToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    if (widget.value) _controller.forward();
  }

  @override
  void didUpdateWidget(DSToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      widget.value ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final activeColor =
        widget.activeColor ??
        (isDark
            ? DSColorsFoundations.brandSecondaryDark
            : DSColorsFoundations.brandSecondary);
    final inactiveColor =
        widget.inactiveColor ??
        (isDark
            ? DSColorsFoundations.surfaceLight.withValues(alpha: 0.3)
            : DSColorsFoundations.surfaceDark.withValues(alpha: 0.3));
    final thumbColor =
        widget.thumbColor ??
        (isDark
            ? DSColorsFoundations.textOnPrimaryDark
            : DSColorsFoundations.textOnPrimary);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => widget.onChanged(widget.value),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final value = _animation.value;

              return Container(
                width: widget.width,
                height: widget.height,
                padding: EdgeInsets.all(widget.height * 0.1),
                decoration: BoxDecoration(
                  color: Color.lerp(inactiveColor, activeColor, value),
                  borderRadius: BorderRadius.circular(
                    DSRadiusFoundations.radiusXL,
                  ),
                  boxShadow: DSShadowsFoundations.shadowSmall,
                ),
                alignment: Alignment.lerp(
                  Alignment.centerLeft,
                  Alignment.centerRight,
                  value,
                ),
                child: Container(
                  width: widget.height * 0.7,
                  height: widget.height * 0.7,
                  decoration: BoxDecoration(
                    color: thumbColor,
                    shape: BoxShape.circle,
                    boxShadow: DSShadowsFoundations.shadowSmall,
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.showLabel && widget.label != null) ...[
          SizedBox(width: DSSizesFoundations.separatorSmall),
          Text(
            widget.label!,
            style: DSTypographyFoundations.bodyMedium.copyWith(
              color: isDark
                  ? DSColorsFoundations.textPrimaryDark
                  : DSColorsFoundations.textPrimary,
            ),
          ),
        ],
      ],
    );
  }
}
