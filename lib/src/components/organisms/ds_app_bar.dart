import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Organismo: DSAppBar
///
/// AppBar adaptable y moderno.
/// Puede mostrar un título, subtítulo, íconos de acción, botón de regreso y color de fondo personalizado.
///
/// Ejemplo de uso:
/// ```dart
/// DSAppBar(
///   title: 'Productos',
///   subtitle: 'Ofertas de hoy',
///   centerTitle: true,
///   showBackButton: true,
///   actions: [
///     IconButton(
///       icon: Icon(Icons.search),
///       onPressed: () {},
///     ),
///   ],
/// )
/// ```
class DSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final bool centerTitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final VoidCallback? onActionIconPress;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? iconActionColor;
  final double elevation;

  const DSAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.centerTitle = false,
    this.showBackButton = true,
    this.onBack,
    this.onActionIconPress,
    this.actions,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.iconActionColor,
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
            ? DSColorsFoundations.textOnPrimaryDark
            : DSColorsFoundations.textOnPrimary);
    final colorText =
        textColor ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    return AppBar(
      elevation: elevation,
      backgroundColor: bg,

      centerTitle: centerTitle,
      animateColor: true,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: iconColor ?? colorText,
              ),
              color: iconColor ?? colorText,
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
                color: colorText,
              ),
            ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: DSTypographyFoundations.labelMedium.copyWith(
                color: colorText.withValues(alpha: 0.7),
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
              child: DSIcon(
                size: DSSize.medium,
                icon: Icons.shopping_cart_outlined,
                color: DSIconColor.primary,
                customColor: iconActionColor ?? colorText,
                onPressed: onActionIconPress,
              ),
            ),
          ],
    );
  }
}
