import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Organismo: AppBar adaptable y moderno.
///
/// Puede mostrar un título, subtítulo, íconos de acción, botón de regreso
/// y color de fondo personalizado.
class DSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final bool centerTitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? textColor;
  final double elevation;

  const DSAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.centerTitle = false,
    this.showBackButton = false,
    this.onBack,
    this.actions,
    this.backgroundColor,
    this.textColor,
    this.elevation = 1.5,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg =
        backgroundColor ??
        (isDark
            ? DSColorsFoundations.backgroundDark
            : DSColorsFoundations.backgroundPrimary);
    final text =
        textColor ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    return AppBar(
      elevation: elevation,
      backgroundColor: bg,
      centerTitle: centerTitle,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              color: text,
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            )
          : null,
      title: Column(
        crossAxisAlignment: centerTitle
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (title != null)
            Text(
              title!,
              style: DSTypographyFoundations.displayMedium.copyWith(
                color: text,
              ),
            ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: DSTypographyFoundations.labelMedium.copyWith(
                color: text.withValues(alpha: 0.7),
              ),
            ),
        ],
      ),
      actions:
          actions ??
          [
            Padding(
              padding: EdgeInsets.only(
                right: DSSizesFoundations.separatorMedium,
              ),
              child: DSIcon(icon: Icons.shopping_cart_outlined),
            ),
          ],
    );
  }
}
