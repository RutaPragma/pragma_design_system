import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Molécula: DSSearchBar
///
/// Barra de búsqueda con input y botón de limpiar.
/// Permite personalizar el hint, controlar el texto y manejar eventos.
///
/// Ejemplo de uso:
/// ```dart
/// DSSearchBar(
///   hintText: 'Buscar productos',
///   onChanged: (value) => print('Buscando: $value'),
///   onClear: () => print('Limpiar búsqueda'),
/// )
/// ```
class DSSearchBar extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onSubmitted;
  final bool autoFocus;
  final bool enabled;

  const DSSearchBar({
    super.key,
    this.hintText = "Buscar...",
    this.controller,
    this.onChanged,
    this.onClear,
    this.onSubmitted,
    this.autoFocus = false,
    this.enabled = true,
  });

  @override
  State<DSSearchBar> createState() => _DSSearchBarState();
}

class _DSSearchBarState extends State<DSSearchBar> {
  bool _hasFocus = false;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    // 👇 Escucha los cambios del texto
    _controller.addListener(() {
      setState(
        () {},
      ); // actualiza el estado para redibujar el icono dinámicamente
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {}); // limpia el listener
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = _hasFocus
        ? (isDark
              ? DSColorsFoundations.surfaceDark.withValues(alpha: 0.2)
              : DSColorsFoundations.surfaceLight.withValues(alpha: 0.2))
        : isDark
        ? DSColorsFoundations.inputFillDark
        : DSColorsFoundations.inputFill;

    final shadow = _hasFocus
        ? DSShadowsFoundations.shadowMedium
        : DSShadowsFoundations.shadowSmall;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusLG),
        border: Border.all(
          color: isDark
              ? DSColorsFoundations.backgroundSecondary.withValues(alpha: 0.1)
              : DSColorsFoundations.backgroundSecondaryDark.withValues(
                  alpha: 0.1,
                ),
        ),
        boxShadow: shadow,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: DSSizesFoundations.separatorMedium,
        vertical: DSSizesFoundations.separatorSmall / 2,
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: _hasFocus
                ? (isDark
                      ? DSColorsFoundations.brandPrimaryDark
                      : DSColorsFoundations.brandPrimary)
                : (isDark
                      ? DSColorsFoundations.textHintDark
                      : DSColorsFoundations.textHint),
            size: DSSizesFoundations.iconSizeMedium,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Focus(
              onFocusChange: (focus) => setState(() => _hasFocus = focus),
              child: TextField(
                controller: _controller,
                autofocus: widget.autoFocus,
                enabled: widget.enabled,
                onChanged: widget.onChanged,
                onSubmitted: (_) => widget.onSubmitted?.call(),
                style: DSTypographyFoundations.bodyMedium.copyWith(
                  color: isDark
                      ? DSColorsFoundations.textPrimaryDark
                      : DSColorsFoundations.textPrimary,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.hintText,
                  hintStyle: DSTypographyFoundations.hint.copyWith(
                    color: isDark
                        ? DSColorsFoundations.textHintDark
                        : DSColorsFoundations.textHint,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // 👇 ahora este ícono aparecerá dinámicamente
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _controller.clear();
                widget.onClear?.call();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Icon(
                  Icons.close_rounded,
                  color: const Color.fromARGB(255, 130, 16, 16),
                  size: DSSizesFoundations.iconSizeSmall,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
